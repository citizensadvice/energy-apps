# frozen_string_literal: true

require "rails_helper"

RSpec.describe CsrTable::SupplierTableRowComponent, type: :component do
  subject { page }

  let(:supplier) { build(:supplier, :ranked) }

  before do
    render_inline described_class.new(supplier)
  end

  it { is_expected.to have_text "1" }
  it { is_expected.to have_text "An Energy Supplier Inc" }
  it { is_expected.to have_css ".stars", count: 4 }
  it { is_expected.to have_css ".stars--highlight", count: 1 }
  it { is_expected.to have_link "More details", href: "#{CSR_APP_PATH}an-energy-supplier-inc/details" }

  context "when the row is highlighted" do
    before do
      render_inline described_class.new(supplier, highlight: true)
    end

    it { is_expected.to have_css ".supplier-table__row--highlight" }
    it { is_expected.to have_no_link "More details" }

    context "when the supplier is not top 3" do
      let(:supplier) { build(:supplier, :low_ranking) }

      it { is_expected.to have_css ".supplier-table__row--top-border" }
    end
  end

  context "when a current country is provided" do
    before do
      render_inline described_class.new(supplier, current_country: "scotland")
    end

    it { is_expected.to have_link "More details", href: "/scotland#{CSR_APP_PATH}an-energy-supplier-inc/details" }
  end
end
