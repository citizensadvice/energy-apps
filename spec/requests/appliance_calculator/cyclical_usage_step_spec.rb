# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Cyclical usage step" do
  context "when the step is requested directly" do
    before do
      get appliance_calculator_daily_usage_creation_step_path("cyclical_usage")
    end

    it "returns the user to the start step" do
      expect(response).to redirect_to(appliance_calculator_daily_usage_creation_step_path("appliance"))
    end
  end
end
