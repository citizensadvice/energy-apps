# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Appliance step" do
  around do |example|
    VCR.use_cassette("daily_usage_creation/steps/appliance", match_requests_on: [:body]) do
      example.run
    end
  end

  context "when the no-js version is requested" do
    before do
      get appliance_calculator_daily_usage_creation_step_path("appliance"), params: { "no-js": true }
    end

    it "renders the no-js layout" do
      expect(response).to render_template("show", with_layout: "appliance_calculator_no_js")
    end

    it "preserves the no-js querystring parameter on subsequent requests" do
      get appliance_calculator_daily_usage_creation_step_path("appliance")

      expect(response).to render_template("show", with_layout: "appliance_calculator_no_js")
    end
  end

  context "when the normal version is requested" do
    before do
      get appliance_calculator_daily_usage_creation_step_path("appliance")
    end

    it "renders the normal layout" do
      expect(response).to render_template("show", with_layout: "appliance_calculator")
    end
  end
end
