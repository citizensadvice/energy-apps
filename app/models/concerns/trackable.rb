# frozen_string_literal: true

module Trackable
  extend ActiveSupport::Concern

  included do
    def next_button_attrs
      {
        data: {
          "gtm-event": "click",
          "gtm-event-name": "next-button-click",
          "gtm-value": id
        }
      }
    end

    def prev_button_attrs
      {
        data: {
          "gtm-event": "click",
          "gtm-event-name": "previous-button-click",
          "gtm-value": id
        }
      }
    end
  end
end
