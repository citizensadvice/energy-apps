# frozen_string_literal: true

FactoryBot.define do
  factory :time_based_daily_usage, class: "TimeBasedDailyUsage" do
    label { "A test appliance (time based)" }
    details { ["Quantity: 1", "Duration: 1 hr 30 minutes"] }
    wattage { 10_000 }
    hours_used { 1.5 }
    additional_kwh { nil }
    preheat_kwh { 0 }

    trait :with_preheat_kwh do
      preheat_kwh { 10 }
    end

    initialize_with do
      new(label:, details:, wattage:, additional_kwh:, hours_used:, preheat_kwh:)
    end
  end
end
