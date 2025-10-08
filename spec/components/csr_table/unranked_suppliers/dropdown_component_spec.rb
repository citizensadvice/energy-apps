# frozen_string_literal: true

require "rails_helper"

RSpec.describe CsrTable::UnrankedSuppliers::DropdownComponent, type: :component do
  subject { page }

  let(:suppliers) do
    build_list(:supplier, 10) do |record, i|
      # generate unique suppliers by adding a suffix letter
      # then shuffle out of alphabetical order
      record.data.name = "An Energy Supplier Inc #{('A'..'Z').to_a[i]}"
      record.data.slug = "an-energy-supplier-inc-#{('a'..'z').to_a[i]}"
      record.data.save!
    end.shuffle!
  end

  let(:chosen_supplier_slug) { nil }

  before do
    render_inline described_class.new(suppliers.presence, chosen_supplier_slug:)
  end

  context "when FF_SMALL_SUPPLIER_STARS is enabled" do
    around do |example|
      ClimateControl.modify(FF_SMALL_SUPPLIER_STARS: "true") do
        example.run
      end
    end

    it { is_expected.to have_text "Smaller suppliers" }
    it { is_expected.to have_css "option", count: 11 }
    it { is_expected.to have_text "Please select" }
    it { is_expected.to have_text alphabetized_suppliers }
    it { is_expected.to have_no_css "option[selected]" }
  end

  context "when FF_SMALL_SUPPLIER_STARS is disabled" do
    around do |example|
      ClimateControl.modify(FF_SMALL_SUPPLIER_STARS: "false") do
        example.run
      end
    end

    it { is_expected.to have_text "Find your supplier" }
    it { is_expected.to have_css "option", count: 11 }
    it { is_expected.to have_text "Please select" }
    it { is_expected.to have_text alphabetized_suppliers }
    it { is_expected.to have_no_css "option[selected]" }
  end

  context "when a chosen supplier slug is passed" do
    let(:chosen_supplier_slug) { "an-energy-supplier-inc-a" }

    it { is_expected.to have_css "option[value*=an-energy-supplier-inc-a]" }
    it { is_expected.to have_css "option[selected]" }
  end

  context "when there are no suppliers" do
    let(:suppliers) { nil }

    it { is_expected.to have_no_text "Please select" }
  end

  private

  def alphabetized_suppliers
    "An Energy Supplier Inc A\nAn Energy Supplier Inc B\nAn Energy Supplier Inc C"
  end
end
