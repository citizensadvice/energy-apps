# frozen_string_literal: true

module DailyUsageCreation
  module Steps
    class Appliance < WizardSteps::Step
      attribute :id, :string
      attribute :quantity, :integer
    end
  end
end
