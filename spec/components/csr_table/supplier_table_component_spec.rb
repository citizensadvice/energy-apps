# frozen_string_literal: true

require "rails_helper"

RSpec.describe CsrTable::SupplierTableComponent, type: :component do
  subject { page }

  let(:suppliers) { build_list(:supplier, 10, :ranked) }

  before do
    render_inline described_class.new(suppliers)
  end

  it { is_expected.to have_selector :table, count: 1 }
  it { is_expected.to have_selector :row, count: 11 }
  it { is_expected.to have_selector :columnheader, "Rank" }
  it { is_expected.to have_selector :columnheader, "Supplier" }
  it { is_expected.to have_selector :columnheader, "Fewer complaints received" }
  it { is_expected.to have_selector :columnheader, "Contact waiting time" }
  it { is_expected.to have_selector :columnheader, "Customer commitments" }
  it { is_expected.to have_selector :columnheader, "Overall rating" }

  context "when FF_NEW_CSR_DATA is enabled" do
    around do |example|
      ClimateControl.modify(FF_NEW_CSR_DATA: "true") do
        example.run
      end
    end

    it { is_expected.to have_selector :columnheader, "Billing and metering" }
  end

  context "when FF_NEW_CSR_DATA is not enabled" do
    around do |example|
      ClimateControl.modify(FF_NEW_CSR_DATA: "false") do
        example.run
      end
    end

    it { is_expected.to have_no_selector :columnheader, "Billing and metering" }
  end
end
