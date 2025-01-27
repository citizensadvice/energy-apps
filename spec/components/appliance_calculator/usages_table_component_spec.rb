# frozen_string_literal: true

require "rails_helper"

RSpec.describe ApplianceCalculator::UsagesTableComponent, type: :component do
  subject(:table) { page }

  before do
    render_inline described_class.new(usages: usages, unit_rate: 10.0)
  end

  it { is_expected.to have_selector :table, count: 1 }
  it { is_expected.to have_selector :row, count: 2 }
  it { is_expected.to have_selector :columnheader, "Appliance" }
  it { is_expected.to have_selector :columnheader, "Daily" }
  it { is_expected.to have_selector :columnheader, "Weekly" }
  it { is_expected.to have_selector :columnheader, "Monthly" }
  it { is_expected.to have_selector :columnheader, "Details" }

  it "formats costs less than £1 correctly" do
    expect(table).to have_text "10p"
  end

  it "formats costs £1 or over correctly" do
    expect(table).to have_text "£2.95"
  end

  it "wraps each details item in a paragraph" do
    expect(table).to have_text "Details line 1"
  end

  def usages
    [
      {
        "label" => "Appliance 1",
        "details" => ["Details line 1", "Details line 2"],
        "kwh_per_day" => 1.0,  # 10p
        "kwh_per_week" => 7.0, # 70p
        "kwh_per_month" => 29.45 # £2.95
      }
    ]
  end
end
