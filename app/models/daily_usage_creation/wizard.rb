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
      # this is all temporary
      usage = if @store[:cyclical?]
                create_cyclical_daily_usage(@store)
              else
                create_time_based_daily_usage(@store)
              end

      Rails.logger.debug "Form complete"
      Rails.logger.info @store.inspect
      Rails.logger.debug usage.to_json
    end

    def create_cyclical_daily_usage(store)
      raise NotImplementedError
    end

    def create_time_based_daily_usage(store)
      TimeBasedDailyUsage.new(
        appliance: {
          name: store["added_appliance"]["data"]["name"],
          wattage: store["added_appliance"]["data"]["wattage"],
          quantity: store["quantity"]
        },
        hours_used: per_day(store["hours"], store["frequency"]),
        minutes_used: per_day(store["minutes"], store["frequency"]),
        additional_usage: store["added_appliance"]["data"]["additionalUsage"]
      )
    end

    def per_day(time, frequency)
      return if time.blank?

      case frequency
      when "daily"
        time
      when "weekly"
        time / 7.to_f
      end
    end
  end
end
