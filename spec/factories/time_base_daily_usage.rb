# frozen_string_literal: true

FactoryBot.define do
  factory :time_based_daily_usage, class: "TimeBasedDailyUsage" do
    label { "A test appliance (time based)" }
    details { ["Quantity: 1", "Duration: 1 hr 30 minutes"] }
    wattage { 10_000 }
    hours_used { 1.5 }

    trait :with_additional_usage do
      hours_used { 1.5 + (10.0 / 60.0) }
    end

    initialize_with do
      new(label:, details:, wattage:, hours_used:)
    end
  end
end
