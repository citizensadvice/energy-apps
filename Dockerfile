FROM ruby:3.3.6-alpine AS base

RUN apk add git --no-cache

RUN gem install bundler -v 2.5.23



FROM base AS dependencies

RUN apk update && apk add build-base yarn nodejs


WORKDIR /tmp

COPY package.json yarn.lock /tmp/
COPY Gemfile* /tmp/

RUN yarn install --frozen-lockfile

RUN bundle config set frozen true \
    && bundle install


# ASSETS
# Uses the DEPENDENCIES layer to build the static assets (CS & JSS)
FROM dependencies AS assets

COPY . /app/

WORKDIR /app

# build assets
RUN bin/rails assets:precompile



# APP
# The final image that is deployed into environments (does not contain any build tools added by DEPENDENCIES)
FROM base AS app

COPY . /app/

COPY --from=dependencies /usr/local/bundle/ /usr/local/bundle/
COPY --from=dependencies /tmp/node_modules/ /app/node_modules/
COPY --from=assets /app/public/ /app/public/


# Add user
RUN adduser -D -u 3000 app \
    && chown app: /app \
    && chown --recursive app: /app/tmp /app/log

WORKDIR /app

USER 3000
EXPOSE 3000

CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
