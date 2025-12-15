# frozen_string_literal: true

require "rails_helper"

RSpec.describe CsrTable::OtherScoresComponent, type: :component do
  subject { page }

  let(:supplier) { build(:supplier, :ranked) }

  before do
    render_inline described_class.new(supplier)
  end

  it { is_expected.to have_text "Other scores" }

  # contact ratings
  it { is_expected.to have_text "Emails responded to within 2 days" }
  it { is_expected.to have_text "89%" }
  it { is_expected.to have_text "Average call centre wait time (hours, minutes and seconds)" }
  it { is_expected.to have_text "03:27" }
  it { is_expected.to have_text "Average response time to social media messages (hours, minutes and seconds)" }
  it { is_expected.to have_text "01:15:00" }

  # complaints ratings
  it { is_expected.to have_text "Complaints to Citizens Advice, Advice Direct Scotland and the Energy Ombudsman" }
  it { is_expected.to have_text "172 per 10,000 customers" }

  # guarantee list
  it { is_expected.to have_text "Customer commitments" }
  it { is_expected.to have_text "Vulnerability Commitment" }

  context "when FF_NEW_CSR_DATA is enabled" do
    around do |example|
      ClimateControl.modify(FF_NEW_CSR_DATA: "true") do
        example.run
      end
    end

    # bills accuracy (traditional)
    it { is_expected.to have_text "Bills accuracy (traditional meter)" }
    it { is_expected.to have_text "98.8%" }

    # bills accuracy (smart)
    it { is_expected.to have_text "Bills accuracy (smart meter)" }
    it { is_expected.to have_text "97.2%" }

    # Smart Operating
    it { is_expected.to have_text "Smart operating" }
    it { is_expected.to have_text "89.4%" }
  end

  context "when there is no supplier" do
    let(:supplier) { nil }

    it { is_expected.to have_no_css "body" }
  end
end
