# frozen_string_literal: true

require "bigdecimal"

# Represents a single day's usage of a given appliance and calculates the kWh consumed for a given timespan
class TimeBasedDailyUsage
  include ActiveModel::Model

  class UnrecognisedTimespanError < StandardError; end

  attr_reader :label, :details

  def initialize(label:, details:, wattage:, hours_used:)
    @label = label
    @details = details
    @wattage = wattage.to_f
    @hours_used = hours_used.to_f
  end

  def to_h
    {
      label: label,
      details: details,
      kwh_per_day: kwh_per(:day),
      kwh_per_week: kwh_per(:week),
      kwh_per_month: kwh_per(:month)
    }
  end

  def kwh_per(timespan)
    case timespan
    when :day
      kilowatts * @hours_used
    when :week
      kilowatts * @hours_used * 7
    when :month
      kilowatts * @hours_used * days_in_a_month
    else
      raise UnrecognisedTimespanError.new(msg: "Unrecognised timespan #{timespan} given to TimeBasedDailyUsage")
    end
  end

  private

  def kilowatts
    @wattage / 1000
  end

  def days_in_a_month
    365.0 / 12.0
  end
end
