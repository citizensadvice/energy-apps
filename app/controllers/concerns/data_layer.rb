# frozen_string_literal: true

module DataLayer
  extend ActiveSupport::Concern

  included do
    def data_layer_properties
      default_data_layer_properties
        .merge(custom_data_layer_properties.to_h)
        .compact
    end
    helper_method :data_layer_properties
  end

  protected

  def custom_data_layer_properties
    {} # page-specific data added at controller level
  end

  def default_data_layer_properties
    properties = {
      platform: "content-platform",
      siteType: "Public Website",
      # language confusingly represents the current country: England, Wales etc.
      # but needs to have this name to match up with Episerver page data.
      language: (helpers.current_country || "england").to_s.capitalize
    }

    if allow_analytics_cookies?
      properties.merge({ analyticsCookiesAccepted: "True" })
    else
      properties
    end
  end
end
