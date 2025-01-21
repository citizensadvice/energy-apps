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

    context "when multiple appliances" do
      subject { build(:time_based_daily_usage, :with_multiple_appliances).kwh_per(timespan) }

      context "when per day" do
        let(:timespan) { :day }

        # (10000 watts / 1000 ) * (90 minutes / 60) * 2 = 30kWh
        it { is_expected.to eq 30 }
      end

      context "when per week" do
        let(:timespan) { :week }

        # (10000 watts / 1000 ) * (90 minutes / 60) * 7 * 2 = 210kWh
        it { is_expected.to eq 210 }
      end

      context "when per month" do
        let(:timespan) { :month }

        # (10000 watts / 1000 ) * (90 minutes / 60) * 365 / 12 * 2 = 912.5kWh
        it { is_expected.to eq 912.5 }
      end
    end

    context "with fractional time used" do
      subject { build(:time_based_daily_usage, :with_fractional_time).kwh_per(timespan) }

      context "when per day" do
        let(:timespan) { :day }

        # (10000 watts / 1000 ) * (1.4268 hours + (30 minutes / 60)) = 19.286kWh
        it { is_expected.to eq 19.286 }
      end

      context "when per week" do
        let(:timespan) { :week }

        # (10000 watts / 1000 ) * (1.4268 hours + (30 minutes / 60)) * 7  = 135.002kWh
        it { is_expected.to eq 135.002 }
      end

      context "when per month" do
        let(:timespan) { :month }

        # (10000 watts / 1000 ) * (1.4268 hours + (30 minutes / 60)) * 365 / 12 * 2 = 586.068333334kWh
        it { is_expected.to eq 586.6158333333334 }
      end
    end

    context "with additional usage" do
      subject { build(:time_based_daily_usage, :with_additional_usage).kwh_per(timespan) }

      context "when per day" do
        let(:timespan) { :day }

        # (10000 watts / 1000 ) * ((90 + 10) minutes / 60) = 16.66666667kWh
        it { is_expected.to eq 16.666666666666664 }
      end

      context "when per week" do
        let(:timespan) { :week }

        # (10000 watts / 1000 ) * ((90 + 10) minutes / 60) * 7  = 116.66666666666666kWh
        it { is_expected.to eq 116.66666666666666 }
      end

      context "when per month" do
        let(:timespan) { :month }

        # (10000 watts / 1000 ) * ((90 + 10) minutes / 60) * 365 / 12 * 2 = 506.9444444444444kWh
        it { is_expected.to eq 506.9444444444444 }
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
