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

  context "when there is no supplier" do
    let(:supplier) { nil }

    it { is_expected.to have_no_css "body" }
  end
end
