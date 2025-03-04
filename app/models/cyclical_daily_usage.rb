# frozen_string_literal: true

# Represents a single day's usage of a given appliance and calculates the kWh consumed for a given timespan
class CyclicalDailyUsage
  include ActiveModel::Model

  class UnrecognisedTimespanError < StandardError; end

  attr_reader :label, :details

  def initialize(label:, details:, wattage:, cycle_quantity:)
    @label = label
    @details = details
    @wattage = wattage.to_f
    @cycle_quantity = cycle_quantity.to_f
  end

  def to_h
    {
      label: label,
      details: details,
      kwh_per_day: kwh_per(:day).round(3),
      kwh_per_week: kwh_per(:week).round(3),
      kwh_per_month: kwh_per(:month).round(3)
    }
  end

  def kwh_per(timespan)
    case timespan
    when :day
      kilowatts * @cycle_quantity
    when :week
      kilowatts * @cycle_quantity * 7
    when :month
      kilowatts * @cycle_quantity * days_in_a_month
    else
      raise UnrecognisedTimespanError.new(msg: "Unrecognised timespan #{timespan} given to CyclicalDailyUsage")
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
