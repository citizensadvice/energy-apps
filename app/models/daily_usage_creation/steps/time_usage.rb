# frozen_string_literal: true

module DailyUsageCreation
  module Steps
    class TimeUsage < WizardSteps::Step
      include ActionView::Helpers::TagHelper
      include Trackable

      attribute :hours, :integer
      attribute :minutes, :integer
      attribute :frequency, :string

      validates :frequency, presence: { message: "Select a frequency from the list" }

      validates_with Validators::TimeUsageValidator

      def label
        "How long do you use #{added_appliance_name}(s) for?"
      end

      # rubocop:disable Layout/LineLength
      def hint_text
        "If you have more than one #{added_appliance_name}, tell us the total time they are used. For example, if you use one appliance for about 1 hour and a second for 30 minutes, add them together. The total time is 1 hour 30 minutes."
      end
      # rubocop:enable Layout/LineLength

      def frequency_options
        [
          FormOption.new(text: "Day", value: :daily),
          FormOption.new(text: "Week", value: :weekly)
        ]
      end

      def skipped?
        @store[:cyclical?]
      end

      def added_appliance_name
        @store[:added_appliance].dig("data", "name") || "appliance"
      end

      def error
        errors[:base].first
      end

      def form_field_classes
        classes = ["cads-form-field"]
        classes << "cads-form-field--has-error" if error.present?
        classes
      end

      def next_button_text
        "Next"
      end
    end
  end
end
