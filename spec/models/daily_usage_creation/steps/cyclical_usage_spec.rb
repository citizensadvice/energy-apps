# frozen_string_literal: true

require "rails_helper"

RSpec.describe DailyUsageCreation::Steps::CyclicalUsage do
  let(:added_appliance) do
    {
      "data" => {
        "sys" => { "id" => "3ejw5FRM0q7YSxw2e8Amrx" },
        "name" => "Tumble Dryer (condenser)",
        "category" => "Large appliances",
        "wattage" => 0,
        "usageType" => "Cycles",
        "additionalUsage" => nil
      }
    }
  end

  describe "valid?" do
    subject(:valid?) { described_class.new(Object.new, WizardSteps::Store.new(store), {}).valid? }

    context "when no number of cycles has been provided" do
      let(:store) { { "added_appliance" => added_appliance, "cycles" => nil, "frequency" => "weekly" } }

      it { is_expected.to be false }
    end

    context "when a non-numerical cycles has been provided" do
      let(:store) { { "added_appliance" => added_appliance, "cycles" => "abc", "frequency" => "weekly" } }

      it { is_expected.to be false }
    end

    context "when a valid cycles has been provided" do
      let(:store) { { "added_appliance" => added_appliance, "cycles" => "1", "frequency" => "weekly" } }

      it { is_expected.to be true }
    end

    context "when no frequency has been provided" do
      let(:store) { { "added_appliance" => added_appliance, "cycles" => "1", "frequency" => nil } }

      it { is_expected.to be false }
    end
  end

  describe "skipped?" do
    subject(:skipped?) { described_class.new(Object.new, WizardSteps::Store.new(store), {}).skipped? }

    context "when the appliance is not cyclical" do
      let(:store) { { "added_appliance" => added_appliance, "cyclical?" => false } }

      it { is_expected.to be true }
    end

    context "when the appliance is cyclical" do
      let(:store) { { "added_appliance" => added_appliance, "cyclical?" => true } }

      it { is_expected.to be false }
    end
  end
end
