# frozen_string_literal: true

module ApplianceCalculator
  class LastAddedApplianceComponent < ViewComponent::Base
    attr_reader :message

    def initialize(message)
      super()
      @message = message
    end

    def render?
      message.present?
    end

    def dismiss_button_attrs
      {
        type: "button",
        class: %w[last-added-appliance__dismiss js-last-added-appliance-dismiss cads-button cads-modal__close-button],
        "aria-label": "Close last added appliance notice"
      }
    end

    def notice_attrs
      {
        data: {
          "gtm-event": "render",
          "gtm-event-name": "app_calc_appliance_added",
          "gtm-value": @message
        }
      }
    end
  end
end
