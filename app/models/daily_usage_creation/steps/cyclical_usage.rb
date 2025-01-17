# frozen_string_literal: true

module DailyUsageCreation
  module Steps
    class CyclicalUsage < WizardSteps::Step
      attribute :cycle_quantity
      attribute :kilowatts

      def skipped?
        !@store[:cyclical?]
      end
    end
  end
end
