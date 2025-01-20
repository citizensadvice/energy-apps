# frozen_string_literal: true

module DailyUsageCreation
  module Steps
    class CyclicalUsage < WizardSteps::Step
      attribute :cycles
      attribute :frequency
      attribute :wattage

      validates :wattage, presence: { message: "Select an option from the list" }, if: ->(model) { model.appliance.variants? }
      validates_with Validators::CycleFrequencyValidator

      def skipped?
        !@store[:cyclical?]
      end

      def appliance
        @appliance ||= ::Appliance.new(data: @store[:added_appliance]["data"])
      end

      def cycle_frequency_error
        errors[:cycle_frequency].first
      end

      def frequency_options
        [
          FormOption.new(text: "Day", value: :daily),
          FormOption.new(text: "Week", value: :weekly)
        ]
      end

      def cycle_frequency_field_classes
        classes = ["cads-form-field"]
        classes << "cads-form-field--has-error" if cycle_frequency_error.present?
        classes
      end
    end
  end
end
