# frozen_string_literal: true

module Cacheable
  extend ActiveSupport::Concern

  included do
    after_action :cache_control_header

    protected

    def cache_control_header
      # Allow clients to cache as we do not have log-in in this app, and cache at the CDN level
      # via s-maxage, allowing stale content to be served if there are upstream errors
      expires_in(
        5.minutes,
        public: true,
        "s-maxage": 5.minutes,
        stale_while_revalidate: 1.minute,
        stale_if_error: 1.day
      )
    end
  end
end
