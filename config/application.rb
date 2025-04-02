# frozen_string_literal: true

require_relative "boot"

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
# require "active_record/railtie"
# require "active_storage/engine"
require "action_controller/railtie"
# require "action_mailer/railtie"
# require "action_mailbox/engine"
# require "action_text/engine"
require "action_view/railtie"
# require "action_cable/engine"
require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module EnergyComparisonTable
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    config.exceptions_app = routes

    # View component previews
    config.view_component.preview_route = "/components/previews"
    config.view_component.default_preview_layout = "component_preview"
    config.view_component.preview_paths << Rails.root.join("spec/components/previews").to_s

    # add rspec test generator
    config.generators.test_framework = :rspec

    config.hosts << /.*\.citizensadvice\.org\.uk/

    # allow health check from private IP addresses
    config.hosts << /10\.\d+\.\d+\.\d+/

    # Set tags for logs, including Datadog trace info
    # This needs to be set here because the logger is already initialized by the
    # time we get to the initializers
    ci_test = ENV.fetch("CI_TEST", false)

    unless $stdout.tty? || ci_test
      config.log_tags = {
        request_id: :request_id,
        dd: lambda { |_|
          correlation = Datadog::Tracing.correlation
          {
            trace_id: correlation.trace_id.to_s,
            span_id: correlation.span_id.to_s,
            env: correlation.env.to_s,
            service: correlation.service.to_s,
            version: correlation.version.to_s
          }
        },
        ddsource: ["ruby"]
      }
    end

    config.session_store :disabled

    config.x.default_unit_rate = 27.03
  end
end
