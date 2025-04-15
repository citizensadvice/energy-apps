# frozen_string_literal: true

require "rails_helper"

RSpec.describe ApplianceCalculator::MostExpensiveApplianceComponent, type: :component do
  subject(:table) { page }

  before do
    render_inline described_class.new(usages)
  end

  context "when there are more than one usages" do
    let(:usages) do
      [
        {
          "label" => "Appliance 2",
          "details" => ["Details line 3"],
          "kwh_per_day" => 2.0,
          "kwh_per_week" => 10.0,
          "kwh_per_month" => 89.0
        },
        {
          "label" => "Appliance 1",
          "details" => ["Details line 1", "Details line 2"],
          "kwh_per_day" => 1.0,
          "kwh_per_week" => 7.0,
          "kwh_per_month" => 29.45
        }
      ]
    end

    it { is_expected.to have_text "Your most expensive appliance in this list is your Appliance 2" }
  end

  context "when there is only one usage" do
    let(:usages) do
      [
        {
          "label" => "Appliance 1",
          "details" => ["Details line 1", "Details line 2"],
          "kwh_per_day" => 1.0,
          "kwh_per_week" => 7.0,
          "kwh_per_month" => 29.45
        }
      ]
    end

    it { is_expected.not_to have_css "body" }
  end

  context "when there are no usages" do
    let(:usages) { nil }

    it { is_expected.not_to have_css "body" }
  end
end
