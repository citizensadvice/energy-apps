# frozen_string_literal: true

require "rails_helper"

RSpec.describe(TimeBasedDailyUsage) do
  # kWh = wattage / 1000 * usage in hours
  describe "#kwh_per" do
    context "when a single appliance" do
      subject { build(:time_based_daily_usage).kwh_per(timespan) }

      context "when per day" do
        let(:timespan) { :day }

        # (10000 watts / 1000 ) * (90 minutes / 60) = 15kWh
        it { is_expected.to eq 15 }
      end

      context "when per week" do
        let(:timespan) { :week }

        # (10000 watts / 1000 ) * (90 minutes / 60) * 7 = 105kWh
        it { is_expected.to eq 105 }
      end

      context "when per month" do
        let(:timespan) { :month }

        # (10000 watts / 1000 ) * (90 minutes / 60) * 365 / 12 = 456.25kWh
        it { is_expected.to eq 456.25 }
      end
    end

    context "with additional kWh" do
      subject { build(:time_based_daily_usage, :with_additional_kwh).kwh_per(timespan) }

      context "when per day" do
        let(:timespan) { :day }

        # (10000 watts / 1000 ) * (90 minutes / 60) + 10kWh = 25kWh
        it { is_expected.to eq 25 }
      end

      context "when per week" do
        let(:timespan) { :week }

        # ((10000 watts / 1000 ) * (90 minutes / 60) + 10kWh) * 7  = 175kWh
        it { is_expected.to eq 175 }
      end

      context "when per month" do
        let(:timespan) { :month }

        # ((10000 watts / 1000 ) * (90 minutes / 60) + 10kWh) * 365 / 12 = 760.4166666666667kWh
        it { is_expected.to eq 760.4166666666667 }
      end
    end

    context "when an unknown timespan is provided" do
      subject(:usage) { build(:time_based_daily_usage) }

      it "raises an error" do
        expect { usage.kwh_per(:banana) }.to raise_error(TimeBasedDailyUsage::UnrecognisedTimespanError)
      end
    end
  end
end
