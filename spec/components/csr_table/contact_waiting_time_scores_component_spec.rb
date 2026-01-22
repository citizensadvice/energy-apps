# frozen_string_literal: true

require "rails_helper"

RSpec.describe CsrTable::ContactWaitingTimeScoresComponent, type: :component do
  subject { page }

  let(:supplier) { build(:supplier, :ranked) }

  before do
    render_inline described_class.new(supplier)
  end

  it { is_expected.to have_text "Contact waiting time" }
  it { is_expected.to have_text "How long can you expect to wait when contacting this supplier?" }

  it { is_expected.to have_text "Emails responded to within 2 days" }
  it { is_expected.to have_text "89%" }
  it { is_expected.to have_text "Average call centre wait time" }
  it { is_expected.to have_text "3 minutes 27 seconds" }

  context "when the supplier has synchronous customer contact channels" do
    let(:supplier) { build(:supplier, :sync_contact) }

    it { is_expected.to have_text "Average Webchat response time" }
    it { is_expected.to have_text "3 minutes" }
    it { is_expected.to have_text "Average Whatsapp response time" }
    it { is_expected.to have_text "1 hour 23 minutes 10 seconds" }
    it { is_expected.to have_text "Average SMS response time" }
    it { is_expected.to have_text "4 hours 47 minutes" }
    it { is_expected.to have_text "Average response time using the supplier's app" }
    it { is_expected.to have_text "39 minutes 16 seconds" }
    it { is_expected.to have_text "Average response time using a customer account portal" }
    it { is_expected.to have_text "1 hour 1 minute 1 second" }
  end

  context "when the supplier has asynchronous customer contact channels" do
    let(:supplier) { build(:supplier, :async_contact) }

    it { is_expected.to have_text "Webchat messages responded to within 2 days" }
    it { is_expected.to have_text "45.7%" }
    it { is_expected.to have_text "Whatsapp messages responded to within 2 days" }
    it { is_expected.to have_text "89.3%" }
    it { is_expected.to have_text "SMS messages responded to within 2 days" }
    it { is_expected.to have_text "99.9%" }
    it { is_expected.to have_text "Messages responded to within 2 days using the supplier's app" }
    it { is_expected.to have_text "74.2%" }
    it { is_expected.to have_text "Messages responded to within 2 days using a customer account portal" }
    it { is_expected.to have_text "82.9%" }
  end

  context "when the supplier has no asynchronous or synchronous customer contact channels" do
    let(:supplier) { build(:supplier, :no_sync_or_async_contact) }

    it { is_expected.to have_text "Emails responded to within 2 days" }
    it { is_expected.to have_text "Average call centre wait time" }

    it { is_expected.to have_no_text "Average Webchat response time" }
    it { is_expected.to have_no_text "Average Whatsapp response time" }
    it { is_expected.to have_no_text "Average SMS response time" }
    it { is_expected.to have_no_text "Average response time using the supplier's app" }
    it { is_expected.to have_no_text "Average response time using a customer account portal" }
    it { is_expected.to have_no_text "Webchat messages responded to within 2 days" }
    it { is_expected.to have_no_text "Whatsapp messages responded to within 2 days" }
    it { is_expected.to have_no_text "SMS messages responded to within 2 days" }
    it { is_expected.to have_no_text "Messages responded to within 2 days using the supplier's app" }
    it { is_expected.to have_no_text "Messages responded to within 2 days using a customer account portal" }
  end

  context "when there is no supplier" do
    let(:supplier) { nil }

    it { is_expected.to have_no_css "body" }
  end
end
