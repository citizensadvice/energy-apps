# frozen_string_literal: true

module ApplianceCalculator
  class ClearListComponent < ViewComponent::Base
    def initialize(usages)
      @usages = usages
    end

    def render?
      @usages.present?
    end

    def attrs
      {
        data:
          {
            "gtm-event": "click",
            "gtm-event-name": "app_calc_clear_list",
            "gtm-value": "clear-list-click"
          }
      }
    end
  end
end
