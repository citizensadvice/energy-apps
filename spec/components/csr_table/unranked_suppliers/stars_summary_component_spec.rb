# frozen_string_literal: true

require "rails_helper"

RSpec.describe CsrTable::UnrankedSuppliers::StarsSummaryComponent, type: :component do
  subject { page }

  context "when FF_SMALL_SUPPLIER_STARS is enabled (disabled by default in tests)" do
    around do |example|
      ClimateControl.modify(FF_SMALL_SUPPLIER_STARS: "true") do
        example.run
      end
    end

    before do
      render_inline described_class.new(build(:supplier))
    end

    it { is_expected.to have_text "You can compare the contact waiting time and customer commitments ratings with other suppliers." }

    context "when FF_NEW_CSR_DATA is enabled" do
      around do |example|
        ClimateControl.modify(FF_NEW_CSR_DATA: "true") do
          example.run
        end
      end

      before do
        render_inline described_class.new(build(:supplier))
      end

      it { is_expected.to have_css ".stars", count: 4 }
      it { is_expected.to have_text "Billing and metering" }
    end

    context "when FF_NEW_CSR_DATA is not enabled" do
      before do
        render_inline described_class.new(build(:supplier))
      end

      it { is_expected.to have_css ".stars", count: 3 }
      it { is_expected.to have_no_text "Billing and metering" }
    end

    context "when there is no supplier" do
      before do
        render_inline described_class.new(nil)
      end

      it { is_expected.to have_no_css "body" }
    end
  end
end
