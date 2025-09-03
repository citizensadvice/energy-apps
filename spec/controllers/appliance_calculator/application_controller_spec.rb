# frozen_string_literal: true

require "rails_helper"

RSpec.describe ApplianceCalculator::ApplicationController do
  describe "#clear" do
    let(:usages) { ["usage 1", "usage 2"] }
    let(:unit_rate) { 20.0 }

    before do
      get :clear, session: { usages: usages, unit_rate: unit_rate }
    end

    it "clears the session of usages" do
      expect(session[:usages]).to be_nil
    end

    it "clears the session of the unit rate" do
      expect(session[:unit_rate]).to be_nil
    end
  end

  describe "#default_data_layer_properties" do
    subject { controller.helpers.data_layer_properties }

    it { is_expected.to include(platform: "content-platform", siteType: "Public Website") }

    context "when FF_NEW_COOKIE_MANAGEMENT is enabled" do
      around do |example|
        ClimateControl.modify(FF_NEW_COOKIE_MANAGEMENT: "true") do
          example.run
        end
      end

      context "when a user has accepted analytics cookies" do
        before { allow(controller).to receive(:allow_analytics_cookies?).and_return(true) }

        it { is_expected.to have_key(:analyticsCookiesAccepted) }
      end

      context "when a user has rejected analytics cookies" do
        before { allow(controller).to receive(:allow_analytics_cookies?).and_return(false) }

        it { is_expected.not_to have_key(:analyticsCookiesAccepted) }
      end
    end

    context "when FF_NEW_COOKIE_MANAGEMENT is not enabled" do
      around do |example|
        ClimateControl.modify(FF_NEW_COOKIE_MANAGEMENT: "false") do
          example.run
        end
      end

      it { is_expected.not_to have_key(:analyticsCookiesAccepted) }
    end
  end
end
