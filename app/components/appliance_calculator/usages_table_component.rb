# frozen_string_literal: true

module ApplianceCalculator
  class UsagesTableComponent < ViewComponent::Base
    def initialize(usages:, unit_rate:)
      super()
      @usages = usages
      @unit_rate = unit_rate
    end

    def render?
      @usages.present? && @unit_rate.present?
    end

    def rows
      @usages.map { |usage| format_usage(usage.symbolize_keys) }
    end

    def format_usage(usage)
      [
        tag.p(usage[:label]),
        tag.p(cost(usage[:kwh_per_day])),
        tag.p(cost(usage[:kwh_per_week])),
        tag.p(cost(usage[:kwh_per_month])),
        details(usage)
      ]
    end

    def cost(kwh)
      return if kwh.blank?

      format_pennies(kwh * @unit_rate.to_f)
    end

    def format_pennies(pennies)
      if pennies >= 100
        number_to_currency(pennies / 100, unit: "£", delimiter: ",", separator: ".")
      else
        "#{pennies.round}p"
      end
    end

    def details(usage)
      safe_join(format_details(usage[:details]))
    end

    def format_details(details)
      details.map do |detail|
        tag.p(detail)
      end
    end

    def formatted_unit_rate
      @unit_rate.to_f.round(2)
    end
  end
end
