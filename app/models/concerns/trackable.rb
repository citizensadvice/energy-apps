# frozen_string_literal: true

module Trackable
  extend ActiveSupport::Concern

  included do
    def next_button_attrs
      {
        data: {
          "gtm-event": "click",
          "gtm-event-name": "app_calc_next_button_click",
          "gtm-value": id
        }
      }
    end

    def prev_button_attrs
      {
        data: {
          "gtm-event": "click",
          "gtm-event-name": "app_calc_previous_button_click",
          "gtm-value": id
        }
      }
    end
  end
end
