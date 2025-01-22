# frozen_string_literal: true

require "rails_helper"

RSpec.describe(DailyUsageCreation::Builders::UsageBuilder) do
  describe "#build" do
    subject { described_class.new(store).build }

    let(:store) do
      WizardSteps::Store.new(
        {
          "cyclical?" => cyclical,
          "added_appliance" => added_appliance,
          "cycles" => "10",
          "frequency" => "weekly",
          "wattage" => "1000"
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
          "wattage" => 0,
          "usageType" => "Cycles",
          "variantOptions" => variant_options
        }
      }
    end

    context "when the appliance is cyclical" do
      let(:cyclical) { true }

      context "when the appliance has no variants" do
        let(:variant_options) { nil }

        it { is_expected.to be_a CyclicalDailyUsage }
        its(:label) { is_expected.to eq "TEST - Tumble Dryer (condenser), 10 cycles per week" }
        its(:details) { is_expected.to eq ["Cycle(s): 10"] }
      end

      context "when the appliance has variants" do
        let(:variant_options) { { "tableData" => [["Option", "Wattage"], ["Full load", "1000"], ["Partial load", "200"]] } }

        its(:label) { is_expected.to eq "TEST - Tumble Dryer (condenser), Full load, 10 cycles per week" }
      end
    end
  end
end
