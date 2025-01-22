# frozen_string_literal: true

FactoryBot.define do
  factory :cyclical_daily_usage, class: "CyclicalDailyUsage" do
    label { "My appliance" }
    details { ["Cycle(s): 2", "Full load"] }
    wattage { 10_000 }
    cycle_quantity { 2 }

    initialize_with do
      new(label:, details:, wattage:, cycle_quantity:)
    end
  end
end
