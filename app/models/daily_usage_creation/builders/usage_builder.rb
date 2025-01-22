# frozen_string_literal: true

module DailyUsageCreation
  module Builders
    class UsageBuilder
      def initialize(store)
        @appliance = ::Appliance.new(data: store[:added_appliance]["data"])
        @store = store
      end

      def build
        raise NotImplementedError unless cyclical?

        build_cyclical_usage
      end

      private

      def cyclical?
        @store["cyclical?"]
      end

      def build_cyclical_usage
        CyclicalDailyUsage.new(
          label: label,
          details: cyclical_details,
          wattage: @store["wattage"],
          cycle_quantity: cycle_quantity
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

      def cycle_quantity
        case @store["frequency"]
        when "daily"
          @store["cycles"]
        else
          @store["cycles"].to_f / 7
        end
      end
    end
  end
end
