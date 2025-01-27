# frozen_string_literal: true

module DailyUsageCreation
  module Steps
    class UnitRate < WizardSteps::Step
      DEFAULT_UNIT_RATE = 24.5

      attribute :unit_rate, :decimal, default: DEFAULT_UNIT_RATE

      validates :unit_rate, presence: { message: "Enter a unit rate in pence per kilowatt hour" },
                            numericality: {
                              greater_than: 0,
                              message: "Enter a unit rate in pence per kilowatt hour"
                            }

      def label
        "The national average rate is #{DEFAULT_UNIT_RATE}p/kWh. You can change it to your rate if you know it.
If you don't know your rate, we'll use the national average of #{DEFAULT_UNIT_RATE}p per kilowatt hour (kWh)"
      end

      def skipped?
        # skip if a unit rate has been entered previously by the user and saved into the session
        # and subsequently the `store` by the `appliance` step of the form
        @store[:saved_unit_rate].present?
      end

      def next_button_text
        "Confirm rate and add appliance"
      end
    end
  end
end
