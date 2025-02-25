# frozen_string_literal: true

require "rails_helper"

RSpec.describe(DailyUsageCreation::Builders::UsageBuilder) do
  subject(:builder) { described_class.new(store) }

  context "when the appliance is cyclical" do
    let(:store) do
      WizardSteps::Store.new(
        {
          "cyclical?" => true,
          "added_appliance" => added_appliance,
          "cycles" => "10",
          "frequency" => "weekly",
          "wattage" => "200"
        }
      )
    end

    let(:added_appliance) do
      {
        "data" => {
          "sys" => {
            "id" => "7mmSMkn7tbxU9l5IXLr6GF"
          },
          "name" => "TEST - Tumble Dryer (condenser)",
          "category" => "Large appliances",
          "wattage" => "1000",
          "usageType" => "Cycles",
          "variantOptions" => variant_options.presence
        }
      }
    end

    let(:cyclical_usage_double) { instance_double(CyclicalDailyUsage) }
    let(:variant_options) { nil }

    before do
      allow(CyclicalDailyUsage).to receive(:new).and_return(cyclical_usage_double)
      builder.build
    end

    it "creates the correct type of usage" do
      expect(CyclicalDailyUsage).to have_received(:new)
    end

    context "when the appliance has no variants" do
      it "passes the correct label, details, wattage and cycle quantity" do
        expected_params = {
          label: "TEST - Tumble Dryer (condenser), 10 cycles per week",
          details: ["Cycle(s): 10 per week"],
          wattage: "1000", # wattage is taken from the appliance
          cycle_quantity: 1.4285714285714286 # 10 cycles per week / 7
        }
        expect(CyclicalDailyUsage).to have_received(:new).with(expected_params)
      end
    end

    context "when the appliance has variants" do
      let(:variant_options) { { "tableData" => [["Option", "Wattage"], ["Full load", "1000"], ["Partial load", "200"]] } }

      it "passes the correct label, details, wattage and cycle quantity" do
        expected_params = {
          label: "TEST - Tumble Dryer (condenser), Partial load, 10 cycles per week",
          details: ["Cycle(s): 10 per week", "Partial load"],
          wattage: "200", # wattage is taken from chosen variant
          cycle_quantity: 1.4285714285714286 # 10 cycles per week / 7
        }
        expect(CyclicalDailyUsage).to have_received(:new).with(expected_params)
      end
    end
  end

  context "when the appliance is not cyclical" do
    let(:hours) { 10 }
    let(:minutes) { 30 }
    let(:store) do
      WizardSteps::Store.new(
        {
          "cyclical?" => false,
          "added_appliance" => added_appliance,
          "hours" => hours,
          "minutes" => minutes,
          "frequency" => "weekly",
          "quantity" => 3,
          "wattage" => "0"
        }
      )
    end

    let(:added_appliance) do
      {
        "data" => {
          "sys" => {
            "id" => "7mmSMkn7tbxU9l5IXLr6GF"
          },
          "name" => "TEST - Light bulb",
          "category" => "Large appliances",
          "wattage" => "500",
          "usageType" => "Time",
          "additionalUsage" => "45"
        }
      }
    end

    let(:time_based_usage_double) { instance_double(TimeBasedDailyUsage) }

    before do
      allow(TimeBasedDailyUsage).to receive(:new).and_return(time_based_usage_double)
      builder.build
    end

    it "creates the correct type of usage" do
      expect(TimeBasedDailyUsage).to have_received(:new)
    end

    it "passes the correct label, details, wattage and hours" do
      expected_params = {
        label: "TEST - Light bulb",
        details: ["Quantity: 3", "Duration: 10 hrs 30 mins per week"],
        wattage: "500", # wattage is taken from the appliance
        hours_used: 1.6071428571428572 # 10 hours + 30 minutes + 45 minutes additional usage = 11.25 hours / 7
      }
      expect(TimeBasedDailyUsage).to have_received(:new).with(expected_params)
    end

    context "when no minutes are provided" do
      let(:minutes) { nil }

      it "passes the correct label, details, wattage and hours" do
        expected_params = {
          label: "TEST - Light bulb",
          details: ["Quantity: 3", "Duration: 10 hrs per week"],
          wattage: "500", # wattage is taken from the appliance
          hours_used: 1.5357142857142858 # 10 hours + 45 minutes additional usage / 7
        }
        expect(TimeBasedDailyUsage).to have_received(:new).with(expected_params)
      end
    end

    context "when no hours are provided" do
      let(:hours) { nil }

      it "passes the correct label, details, wattage and hours" do
        expected_params = {
          label: "TEST - Light bulb",
          details: ["Quantity: 3", "Duration: 30 mins per week"],
          wattage: "500", # wattage is taken from the appliance
          hours_used: 0.17857142857142858 # 30 minutes + 45 minutes additional usage / 7
        }
        expect(TimeBasedDailyUsage).to have_received(:new).with(expected_params)
      end
    end
  end
end
