# frozen_string_literal: true

module DailyUsageCreation
  module Steps
    class TimeUsage < WizardSteps::Step
      include ActionView::Helpers::TagHelper

      attribute :hours, :integer
      attribute :minutes, :integer
      attribute :frequency, :string

      validates :frequency, presence: { message: "Select a frequency from the list" }

      validates_with Validators::TimeUsageValidator

      def label
        "On average, how often do you use #{added_appliance_name}(s)?"
      end

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
