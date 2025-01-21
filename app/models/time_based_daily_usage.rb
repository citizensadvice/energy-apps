# frozen_string_literal: true

require "bigdecimal"

# Represents a single day's usage of a given appliance and calculates the kWh consumed for a given timespan
class TimeBasedDailyUsage
  include ActiveModel::Model

  class UnrecognisedTimespanError < StandardError; end

  attr_reader :appliance_name

  def initialize(appliance:, hours_used:, minutes_used:, additional_usage:)
    @appliance_name = appliance[:name]
    @appliance_quantity = appliance[:quantity]
    @wattage = appliance[:wattage].to_f
    @hours_used = hours_used.to_f || 0.0
    @minutes_used = minutes_used.to_f || 0.0
    @additional_usage = additional_usage.to_f || 0.0
  end

  def kwh_per(timespan)
    case timespan
    when :day
      kilowatts * hours_used_per_day
    when :week
      kilowatts * hours_used_per_day * 7
    when :month
      kilowatts * hours_used_per_day * days_in_a_month
    else
      raise UnrecognisedTimespanError.new(msg: "Unrecognised timespan #{timespan} given to TimeBasedDailyUsage")
    end
  end

  private

  def hours_used_per_day
    @hours_used + ((@minutes_used + @additional_usage) / 60)
  end

  def kilowatts
    @appliance_quantity * @wattage / 1000
  end

  def days_in_a_month
    365.0 / 12.0
  end
end
