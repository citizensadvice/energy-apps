# frozen_string_literal: true

require "rails_helper"

RSpec.describe DailyUsageCreation::Steps::TimeUsage do
  describe "valid?" do
    subject(:valid?) { described_class.new(Object.new, WizardSteps::Store.new(store), {}).valid? }

    let(:appliance_data) do
      { "data" =>
                    { "sys" =>
                       { "id" => "1EKZxnrrKOcTO5wvf57ABn" },
                      "name" => "Fan heater",
                      "category" => "Heating",
                      "wattage" => 2500,
                      "usageType" => "Time",
                      "additionalKWh" => nil,
                      "variantQuestion" => nil,
                      "variantOptions" => nil } }
    end

    context "when no values for hours and minutes have been provided" do
      let(:store) do
        {
          "added_appliance" => appliance_data,
          "quantity" => 1,
          "hours" => nil,
          "minutes" => nil,
          "frequency" => "daily"
        }
      end

      it { is_expected.to be false }
    end

    context "when no value for hours but some values for minutes have been provided" do
      let(:store) { { "added_appliance" => appliance_data, "quantity" => 1, "hours" => nil, "minutes" => 10, "frequency" => "daily" } }

      it { is_expected.to be true }
    end

    context "when zero values for hours and minutes have been provided" do
      let(:store) { { "added_appliance" => appliance_data, "quantity" => 1, "hours" => 0, "minutes" => 0, "frequency" => "daily" } }

      it { is_expected.to be false }
    end

    context "when too many minutes are provided" do
      let(:store) { { "added_appliance" => appliance_data, "quantity" => 1, "hours" => 0, "minutes" => 100, "frequency" => "daily" } }

      it { is_expected.to be false }
    end

    context "when 59 minutes is provided" do
      let(:store) { { "added_appliance" => appliance_data, "quantity" => 1, "hours" => 0, "minutes" => 59, "frequency" => "daily" } }

      it { is_expected.to be true }
    end

    context "when fewer than 59 minutes is provided" do
      let(:store) { { "added_appliance" => appliance_data, "quantity" => 1, "hours" => 0, "minutes" => 45, "frequency" => "daily" } }

      it { is_expected.to be true }
    end

    context "when 24 hours and no minutes are provided" do
      let(:store) { { "added_appliance" => appliance_data, "quantity" => 1, "hours" => 24, "minutes" => 0, "frequency" => "daily" } }

      it { is_expected.to be true }
    end

    context "when less than 24 hours and some minutes are provided" do
      let(:store) { { "added_appliance" => appliance_data, "quantity" => 1, "hours" => 23, "minutes" => 45, "frequency" => "daily" } }

      it { is_expected.to be true }
    end

    context "when 24 hours and some minutes are provided" do
      let(:store) { { "added_appliance" => appliance_data, "quantity" => 1, "hours" => 24, "minutes" => 45, "frequency" => "daily" } }

      it { is_expected.to be false }
    end

    context "when the frequency is weekly" do
      context "when 24 * 7 hours and no minutes are provided" do
        let(:store) { { "added_appliance" => appliance_data, "quantity" => 1, "hours" => 168, "minutes" => 0, "frequency" => "weekly" } }

        it { is_expected.to be true }
      end

      context "when less than 24 * 7 hours and some minutes are provided" do
        let(:store) { { "added_appliance" => appliance_data, "quantity" => 1, "hours" => 167, "minutes" => 45, "frequency" => "weekly" } }

        it { is_expected.to be true }
      end

      context "when 24 * 7 hours and some minutes are provided" do
        let(:store) { { "added_appliance" => appliance_data, "quantity" => 1, "hours" => 168, "minutes" => 30, "frequency" => "weekly" } }

        it { is_expected.to be false }
      end
    end

    context "when no frequency is provided" do
      let(:store) { { "added_appliance" => appliance_data, "quantity" => 1, "hours" => 1, "minutes" => 0, "frequency" => nil } }

      it { is_expected.to be false }
    end

    context "when more than one appliance is provided" do
      context "when 24 * 7 hours per appliance and no minutes are provided" do
        let(:store) { { "added_appliance" => appliance_data, "quantity" => 2, "hours" => 336, "minutes" => 0, "frequency" => "weekly" } }

        it { is_expected.to be true }
      end

      context "when less than 24 * 7 hours per appliance and some minutes are provided" do
        let(:store) { { "added_appliance" => appliance_data, "quantity" => 2, "hours" => 335, "minutes" => 45, "frequency" => "weekly" } }

        it { is_expected.to be true }
      end

      context "when 24 * 7 hours per appliance and some minutes are provided" do
        let(:store) { { "added_appliance" => appliance_data, "quantity" => 2, "hours" => 337, "minutes" => 30, "frequency" => "weekly" } }

        it { is_expected.to be false }
      end
    end
  end

  describe "skipped?" do
    subject(:skipped?) { described_class.new(Object.new, WizardSteps::Store.new(store), {}).skipped? }

    context "when the appliance is not cyclical" do
      let(:store) { { "cyclical?" => false } }

      it { is_expected.to be false }
    end

    context "when the appliance is cyclical" do
      let(:store) { { "cyclical?" => true } }

      it { is_expected.to be true }
    end
  end
end
