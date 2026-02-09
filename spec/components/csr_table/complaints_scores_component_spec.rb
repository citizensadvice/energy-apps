# frozen_string_literal: true

require "rails_helper"

RSpec.describe CsrTable::ComplaintsScoresComponent, type: :component do
  subject { page }

  let(:supplier) { build(:supplier, :ranked) }

  before do
    render_inline described_class.new(supplier)
  end

  it { is_expected.to have_text "Fewer complaints received" }

  it { is_expected.to have_text "Complaints to Citizens Advice, Advice Direct Scotland and the Energy Ombudsman" }
  it { is_expected.to have_text "172 per 10,000 customers" }

  context "when there is no supplier" do
    let(:supplier) { nil }

    it { is_expected.to have_no_css "body" }
  end
end
