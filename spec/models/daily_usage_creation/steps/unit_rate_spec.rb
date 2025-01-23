# frozen_string_literal: true

require "rails_helper"

RSpec.describe DailyUsageCreation::Steps::UnitRate do
  describe "valid?" do
    subject(:valid?) { described_class.new(Object.new, WizardSteps::Store.new(store), {}).valid? }

    context "when no unit rate has been provided" do
      let(:store) { { "unit_rate" => nil } }

      it { is_expected.to be false }
    end

    context "when a zero unit rate has been provided" do
      let(:store) { { "unit_rate" => 0 } }

      it { is_expected.to be false }
    end

    context "when a non-numerical unit rate has been provided" do
      let(:store) { { "unit_rate" => "abc" } }

      it { is_expected.to be false }
    end

    context "when a unit rate has been provided" do
      let(:store) { { "unit_rate" => "1.5" } }

      it { is_expected.to be true }
    end
  end

  describe "skipped?" do
    subject(:skipped?) { described_class.new(Object.new, WizardSteps::Store.new(store), {}).skipped? }

    context "when there is already a unit rate in the store" do
      let(:store) { { "saved_unit_rate" => "1" } }

      it { is_expected.to be true }
    end

    context "when there is no unit rate in the store" do
      let(:store) { { "saved_unit_rate" => nil } }

      it { is_expected.to be false }
    end
  end
end
