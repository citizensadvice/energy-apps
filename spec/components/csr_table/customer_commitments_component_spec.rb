# frozen_string_literal: true

require "rails_helper"

RSpec.describe CsrTable::CustomerCommitmentsComponent, type: :component do
  subject { page }

  let(:supplier) { build(:supplier, :ranked) }

  before do
    render_inline described_class.new(supplier)
  end

  it { is_expected.to have_text "Customer commitments" }

  it { is_expected.to have_text "Is the supplier a member of the Energy Switch Guarantee or the Vulnerability Commitment?" }

  context "when the supplier is signed up to both schemes" do
    let(:supplier) { build(:supplier, :both_guarantee_schemes) }

    it { is_expected.to have_text "Switch Guarantee, Vulnerability Commitment" }
  end

  context "when the supplier is not signed up to either scheme" do
    let(:supplier) { build(:supplier, :no_guarantee_schemes) }

    it { is_expected.to have_text "None" }
  end

  context "when there is no supplier" do
    let(:supplier) { nil }

    it { is_expected.to have_no_css "body" }
  end
end
