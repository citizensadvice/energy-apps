# frozen_string_literal: true

module DailyUsageCreation
  class Wizard < WizardSteps::Base
    self.steps = [
      Steps::Appliance,
      Steps::TimeUsage,
      Steps::CyclicalUsage,
      Steps::UnitRate
    ].freeze

    private

    def do_complete
      Rails.logger.debug "Form complete"
    end
  end
end
