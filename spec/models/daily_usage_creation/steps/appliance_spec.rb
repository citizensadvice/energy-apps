# frozen_string_literal: true

require "rails_helper"

RSpec.describe DailyUsageCreation::Steps::Appliance do
  describe "valid?" do
    subject(:valid?) { described_class.new(Object.new, WizardSteps::Store.new(store), {}).valid? }

    context "when an appliance is selected and a quantity is given" do
      let(:store) { { "quantity" => 1, "appliance_id" => "12345" } }

      it { is_expected.to be true }
    end

    context "when no appliance is selected" do
      let(:store) { { "appliance_id" => "" } }

      it { is_expected.to be false }
    end

    context "when no quantity is given" do
      let(:store) { { "quantity" => nil } }

      it { is_expected.to be false }
    end

    context "when quantity is zero" do
      let(:store) { { "quantity" => 0 } }

      it { is_expected.to be false }
    end

    context "when a non-numeric quantity is given" do
      let(:store) { { "quantity" => "this many" } }

      it { is_expected.to be false }
    end
  end

  describe "#save!" do
    subject(:step) { described_class.new(Object.new, WizardSteps::Store.new(store), {}) }

    around do |example|
      ClimateControl.modify(USE_TEST_SUPPLIERS: "true") do
        VCR.use_cassette("daily_usage_creation/steps/appliance", match_requests_on: [:body]) do
          example.run
        end
      end
    end

    context "when the step is submitted successfully with a time based usage appliance" do
      let(:store) { { "quantity" => 1, "appliance_id" => "2hf9PSZCdpYwQ40HsPmx8b" } }

      it "saves the appliance into the store" do
        step.save!
        expect(store["added_appliance"]).to be_present
      end

      it "marks the chosen appliance an non-cyclical" do
        step.save!
        expect(store["cyclical?"]).to be false
      end
    end

    context "when the step is submitted successfully with a cycle based usage appliance" do
      let(:store) { { "quantity" => 1, "appliance_id" => "5pL9EpewLPF4fZzP0BbtwY" } }

      it "marks the chosen appliance an non-cyclical" do
        step.save!
        expect(store["cyclical?"]).to be true
      end
    end
  end
end
