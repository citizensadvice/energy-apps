# frozen_string_literal: true

require "rails_helper"

RSpec.describe(CyclicalDailyUsage) do
  # kWh = wattage per cycle / 1000 * number of cycles
  describe "#kwh_per" do
    subject { build(:cyclical_daily_usage).kwh_per(timespan) }

    context "when per day" do
      let(:timespan) { :day }

      # (10000 watts / 1000 ) * 2 = 20kWh
      it { is_expected.to eq 20 }
    end

    context "when per week" do
      let(:timespan) { :week }

      # (10000 watts / 1000 ) * 2 * 7 = 140kWh
      it { is_expected.to eq 140 }
    end

    context "when per month" do
      let(:timespan) { :month }

      # (10000 watts / 1000 ) * 2 * 365 / 12 = 608.3333333333334kWh
      it { is_expected.to eq 608.3333333333334 }
    end
  end
end
