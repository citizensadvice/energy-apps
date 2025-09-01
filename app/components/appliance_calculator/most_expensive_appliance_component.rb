# frozen_string_literal: true

module ApplianceCalculator
  class MostExpensiveApplianceComponent < ViewComponent::Base
    def initialize(usages)
      super()
      @usages = usages
    end

    def render?
      @usages.present? && @usages.size > 1
    end

    def text
      "Your most expensive appliance in this list is your #{@usages.first['label']}"
    end

    def callout_attrs
      {
        data: {
          "gtm-event": "render",
          "gtm-event-name": "app_calc_most_expensive_appliance",
          "gtm-value": @usages.first["label"]
        }
      }
    end
  end
end
