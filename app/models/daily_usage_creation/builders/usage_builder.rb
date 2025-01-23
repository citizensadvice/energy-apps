# frozen_string_literal: true

module DailyUsageCreation
  module Builders
    class UsageBuilder
      def initialize(store)
        @appliance = ::Appliance.new(data: store[:added_appliance]["data"])
        @store = store
      end

      def build
        if cyclical?
          build_cyclical_usage
        else
          build_time_based_usage
        end
      end

      private

      def cyclical?
        @store["cyclical?"]
      end

      def build_cyclical_usage
        CyclicalDailyUsage.new(
          label: label,
          details: cyclical_details,
          wattage: cyclical_wattage,
          cycle_quantity: cycle_quantity
        )
      end

      def build_time_based_usage
        TimeBasedDailyUsage.new(
          label: label,
          details: time_based_details,
          wattage: @appliance.data["wattage"],
          hours_used: hours_per_day
        )
      end

      def label
        return @appliance.data["name"] unless cyclical?

        [@appliance.data["name"], selected_variant_text, cycle_text].compact.join(", ")
      end

      def selected_variant_text
        return if @appliance.variant_options.blank?

        variant = @appliance.variant_options.find { |option| option.value == @store["wattage"] }
        variant.text
      end

      def cycle_text
        frequency = case @store["frequency"]
                    when "daily"
                      "day"
                    else
                      "week"
                    end

        "#{@store['cycles']} cycles per #{frequency}"
      end

      def cyclical_details
        [
          "Cycle(s): #{@store['cycles']}",
          selected_variant_text
        ].compact
      end

      def cyclical_wattage
        @appliance.variants? ? @store["wattage"] : @appliance.data["wattage"]
      end

      def time_based_details
        [
          "Quantity: #{@store['quantity']}",
          "Duration: #{duration}"
        ]
      end

      def cycle_quantity
        case @store["frequency"]
        when "daily"
          @store["cycles"]
        else
          @store["cycles"].to_f / 7
        end
      end

      def hours_per_day
        total_hours = @store["hours"].to_f

        total_hours += (@store["minutes"].to_f / 60) if @store["minutes"].present?

        total_hours += (@appliance.data["additionalUsage"].to_f / 60) if @appliance.data["additionalUsage"].present?

        daily_hours(total_hours)
      end

      def daily_hours(hours)
        case @store["frequency"]
        when "daily"
          hours
        else
          hours / 7
        end
      end

      def duration
        hours = @store["hours"]
        minutes = @store["minutes"]

        [
          ("#{hours} hrs" if hours.present? && hours.positive?),
          ("#{minutes} mins" if minutes.present? && minutes.positive?)
        ].compact.join(" ")
      end
    end
  end
end
