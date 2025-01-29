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
end
