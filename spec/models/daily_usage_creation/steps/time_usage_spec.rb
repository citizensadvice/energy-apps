# frozen_string_literal: true

require "rails_helper"

RSpec.describe DailyUsageCreation::Steps::TimeUsage do
  describe "valid?" do
    subject(:valid?) { described_class.new(Object.new, WizardSteps::Store.new(store), {}).valid? }

    context "when no values for hours and minutes have been provided" do
      let(:store) { { "hours" => nil, "minutes" => nil, "frequency" => "daily" } }

      it { is_expected.to be false }
    end

    context "when zero values for hours and minutes have been provided" do
      let(:store) { { "hours" => 0, "minutes" => 0, "frequency" => "daily" } }

      it { is_expected.to be false }
    end

    context "when too many minutes are provided" do
      let(:store) { { "hours" => 0, "minutes" => 100, "frequency" => "daily" } }

      it { is_expected.to be false }
    end

    context "when 59 minutes is provided" do
      let(:store) { { "hours" => 0, "minutes" => 59, "frequency" => "daily" } }

      it { is_expected.to be true }
    end

    context "when fewer than 59 minutes is provided" do
      let(:store) { { "hours" => 0, "minutes" => 45, "frequency" => "daily" } }

      it { is_expected.to be true }
    end

    context "when 24 hours and no minutes are provided" do
      let(:store) { { "hours" => 24, "minutes" => 0, "frequency" => "daily" } }

      it { is_expected.to be true }
    end

    context "when less than 24 hours and some minutes are provided" do
      let(:store) { { "hours" => 23, "minutes" => 45, "frequency" => "daily" } }

      it { is_expected.to be true }
    end

    context "when 24 hours and some minutes are provided" do
      let(:store) { { "hours" => 24, "minutes" => 45, "frequency" => "daily" } }

      it { is_expected.to be false }
    end

    context "when the frequency is weekly" do
      context "when 24 * 7 hours and no minutes are provided" do
        let(:store) { { "hours" => 168, "minutes" => 0, "frequency" => "weekly" } }

        it { is_expected.to be true }
      end

      context "when less than 24 * 7 hours and some minutes are provided" do
        let(:store) { { "hours" => 167, "minutes" => 45, "frequency" => "weekly" } }

        it { is_expected.to be true }
      end

      context "when 24 * 7 hours and some minutes are provided" do
        let(:store) { { "hours" => 168, "minutes" => 30, "frequency" => "weekly" } }

        it { is_expected.to be false }
      end
    end

    context "when no frequency is provided" do
      let(:store) { { "hours" => 1, "minutes" => 0, "frequency" => nil } }

      it { is_expected.to be false }
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
