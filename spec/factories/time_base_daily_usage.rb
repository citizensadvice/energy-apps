# frozen_string_literal: true

FactoryBot.define do
  factory :time_based_daily_usage, class: "TimeBasedDailyUsage" do
    appliance_name { "A test appliance (time based)" }
    appliance_quantity { 1 }
    wattage { 10_000 }
    hours_used { 1 }
    minutes_used { 30 }
    additional_usage { nil }

    trait :with_additional_usage do
      additional_usage { 10 }
    end

    trait :with_fractional_time do
      hours_used { 1.4286 } # 10 hours per week
    end

    trait :with_multiple_appliances do
      appliance_quantity { 2 }
    end

    initialize_with { new(appliance: { name: appliance_name, quantity: appliance_quantity, wattage: }, hours_used:, minutes_used:, additional_usage:) }
  end
end
