# frozen_string_literal: true

# Be sure to restart your server when you modify this file.

# Define an application-wide content security policy.
# See the Securing Rails Applications Guide for more information:
# https://guides.rubyonrails.org/security.html#content-security-policy-header

# rubocop:disable Metrics/BlockLength
Rails.application.configure do
  config.content_security_policy do |policy|
    merge_into = lambda { |directive, *args|
      old = Array(policy.send(directive)).without("'none'")
      policy.send(directive, *old, *args)
      # Dedupe - old will contain mapped names, for example :self => "'self'"
      policy.send(directive, *policy.send(directive).uniq)
    }

    policy.default_src :self, :https
    policy.font_src    :self, :https, :data
    policy.img_src     :self, :https, :data
    policy.object_src  :none
    policy.script_src  :self, :https
    policy.style_src   :self, :https
    policy.frame_src   :self
    policy.frame_ancestors :self, "*.citizensadvice.org.uk"
    # Specify URI for violation reports
    # policy.report_uri "/csp-violation-report-endpoint"

    # Google Tag manager
    # @see {https://developers.google.com/tag-manager/web/csp}
    # unsafe-eval is required as we have several Custom Javascript variables
    # in our Tag Manager setup, Google recommend using Custom Templates instead
    # to avoid requiring this setting but for now we require it.
    # @see {https://developers.google.com/tag-platform/security/guides/csp#custom_javascript_variables}
    merge_into[:script_src, :unsafe_eval, "https://www.googletagmanager.com"]
    merge_into[:img_src, "https:"] # following the episerver approach to allow google ad tracking pixels (for Help to Claim)
    merge_into[:frame_src, "https://www.googletagmanager.com"]

    # Tag manager preview mode
    # @see {https://developers.google.com/tag-platform/security/guides/csp#preview_mode}
    merge_into[:script_src, "https://googletagmanager.com", "https://tagmanager.google.com"]
    merge_into[:style_src, :unsafe_inline, "https://googletagmanager.com", "https://tagmanager.google.com", "https://fonts.googleapis.com"]
    merge_into[:img_src, "https://googletagmanager.com", "https://ssl.gstatic.com", "https://www.gstatic.com"]
    merge_into[:font_src, "https://fonts.gstatic.com", :data]

    # Universal analytics
    # @see {https://developers.google.com/tag-platform/security/guides/csp#universal_analytics_google_analytics}
    merge_into[:script_src, "https://www.google-analytics.com", "https://ssl.google-analytics.com"]
    merge_into[:img_src, "https://www.google-analytics.com", "https://www.google.com", "https://www.google.co.uk"]
    merge_into[:connect_src, "https://www.google-analytics.com", "https://stats.g.doubleclick.net"]
    # :img_src doesn't seem to need https://www.google.com or https://www.google.co.uk per guidance
    # :connect_src doesn't seem to need https://stats.g.doubleclick.net per guidance

    # Google Analytics 4
    # @see {https://developers.google.com/tag-platform/security/guides/csp#google_analytics_4_google_analytics}
    merge_into[:script_src, "*.googletagmanager.com"]
    merge_into[:img_src, "*.google-analytics.com", "*.googletagmanager.com"]
    merge_into[:connect_src, "*.google-analytics.com", "*.analytics.google.com", "*.googletagmanager.com"]

    # seems to also be needed to allow GA to be set up completely
    # merge_into[:style_src, :unsafe_inline]

    # Geolocation - NP-3018
    merge_into[:script_src, "'sha256-MtkotRM6KOAOo1saTZwgZ8kKWigT1Za4LlZ205dKQFo='"]

    merge_into[:frame_ancestors, "localhost:*"] if Rails.env.development?

    # DataDog JS error logging
    merge_into[:connect_src, "https://browser-intake-datadoghq.eu"]

    # Fundraising Regulator logo (we have to use the third party hosted one to demonstrate the validation)
    merge_into[:img_src, "https://www.fundraisingregulator.org.uk"]
  end
  # rubocop:enable Metrics/BlockLength

  # Generate session nonces for permitted importmap and inline scripts
  config.content_security_policy_nonce_generator = ->(_request) { SecureRandom.base64(16) }
  config.content_security_policy_nonce_directives = %w[script-src]

  # Report violations without enforcing the policy.
  # config.content_security_policy_report_only = true
end
