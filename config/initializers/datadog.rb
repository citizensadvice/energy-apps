# frozen_string_literal: true

# Share a service name in order to group all integrations
service_name = ENV.fetch("DD_SERVICE", "energy-apps")
ci_test = ENV.fetch("CI_TEST", false)
SemanticLogger.application = service_name

# Disable datadog if stdout is a TTY because it probably means a user is running
# Rails in a terminal
unless $stdout.tty? || ci_test
  Datadog.configure do |c|
    traced_headers = {
      request: %w[
        Host
        Referer
        X-Forwarded-Host
        X-Forwarded-For
      ]
    }

    c.service = service_name
    c.tracing.instrument :rails, headers: traced_headers
    c.tracing.instrument :faraday, describes: /graphql\.contentful\.com/, service_name: "#{service_name}-contentful-graphql"
  end
end
