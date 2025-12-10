# frozen_string_literal: true

require "rails_helper"

RSpec.describe CsrTable::ScoreSummaryComponent, type: :component do
  subject { page }

  let(:supplier) { build(:supplier, :ranked) }
  let(:quarter_date) { build(:quarter_date) }

  before do
    render_inline described_class.new(supplier, quarter_date.body)
  end

  it { is_expected.to have_text "An Energy Supplier Inc scores for October to December 2023" }
  it { is_expected.to have_css ".stars", count: 4 }

  context "when FF_NEW_CSR_DATA is enabled" do
    around do |example|
      ClimateControl.modify(FF_NEW_CSR_DATA: "true") do
        example.run
      end
    end

    it { is_expected.to have_text "Billing and metering" }
  end

  context "when FF_NEW_CSR_DATA is disabled" do
    around do |example|
      ClimateControl.modify(FF_NEW_CSR_DATA: "false") do
        example.run
      end
    end

    it { is_expected.to have_no_text "Billing and metering" }
  end

  context "when there is no supplier" do
    let(:supplier) { nil }

    it { is_expected.to have_no_css "body" }
  end
end
