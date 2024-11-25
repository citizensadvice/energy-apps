FROM ruby:3.3.6-alpine3.19

RUN apk update && apk add --no-cache build-base yarn libxml2 libxslt gcompat git

RUN gem install bundler -v '~>2.3'

WORKDIR /app

COPY Gemfile Gemfile.lock /app/

RUN bundle config set --local deployment 'true' && \  
    bundle install

COPY package.json yarn.lock /app/
RUN yarn install --frozen-lockfile

COPY ./ /app

RUN bundle exec rake assets:precompile RAILS_ENV=production

# Add user group
RUN addgroup ruby

# Add user
RUN adduser -h /home/ruby -D 3000 ruby 

# Change temp and log dir perms
RUN rm -rf /app/tmp /app/log \
&& mkdir /app/tmp /app/log \
&& chmod -R 777 /app/tmp /app/log

USER 3000

CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
