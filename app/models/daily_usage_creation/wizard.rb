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
      Rails.logger.info @store.inspect
      # return the usage and the unit rate so they can both be persisted
      {
        usage: Builders::UsageBuilder.new(@store).build,
        rate: @store["saved_unit_rate"] || @store["unit_rate"]
      }
    end
  end
end
