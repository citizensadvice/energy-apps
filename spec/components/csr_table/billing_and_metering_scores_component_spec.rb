# frozen_string_literal: true

require "rails_helper"

RSpec.describe CsrTable::BillingAndMeteringScoresComponent, type: :component do
  subject { page }

  let(:supplier) { build(:supplier, :ranked) }

  before do
    render_inline described_class.new(supplier)
  end

  it { is_expected.to have_text "Billing and metering" }

  it { is_expected.to have_text "Bills accuracy (smart meters)" }
  it { is_expected.to have_text "Bills accuracy (traditional meters)" }
  it { is_expected.to have_text "Smart meters working correctly" }

  context "when there is billing data" do
    it { is_expected.to have_text "98.3%" }
    it { is_expected.to have_text "82.9%" }
    it { is_expected.to have_text "91.7%" }
  end

  context "when there is no billing data" do
    let(:supplier) { build(:supplier, :no_billing_data) }

    it { is_expected.to have_text "N/A", count: 3 }
  end

  context "when there is no supplier" do
    let(:supplier) { nil }

    it { is_expected.to have_no_css "body" }
  end
end
