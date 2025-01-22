# frozen_string_literal: true

require "rails_helper"

RSpec.describe(DailyUsageCreation::Builders::UsageBuilder) do
  describe "#build" do
    subject(:builder) { described_class.new(store) }

    let(:store) do
      WizardSteps::Store.new(
        {
          "cyclical?" => cyclical,
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

    context "when the appliance is cyclical" do
      let(:cyclical) { true }
      let(:variant_options) { nil }

      let(:cyclical_usage_double) { instance_double(CyclicalDailyUsage) }

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
            details: ["Cycle(s): 10"],
            wattage: "1000", # wattage is taken from the appliance not the chosen input
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
            details: ["Cycle(s): 10", "Partial load"],
            wattage: "200", # wattage is taken from chosen input
            cycle_quantity: 1.4285714285714286 # 10 cycles per week / 7
          }
          expect(CyclicalDailyUsage).to have_received(:new).with(expected_params)
        end
      end
    end
  end
end
