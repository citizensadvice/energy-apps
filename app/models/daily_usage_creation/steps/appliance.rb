# frozen_string_literal: true

module DailyUsageCreation
  module Steps
    class Appliance < WizardSteps::Step
      attribute :appliance_id, :string
      attribute :quantity, :integer, default: 1

      validates :appliance_id, presence: { message: "Select an appliance from the list" }
      validates :quantity, presence: { message: "Enter a number of appliances greater than 0, for example 1" },
                           numericality: { greater_than: 0, message: "Enter a number of appliances greater than 0, for example 1" }

      def appliances
        ::Appliance.fetch_all
      end
    end
  end
end
