# frozen_string_literal: true

module ApplianceCalculator
  class ApplianceCalculatorController < ApplicationController
    layout "appliance_calculator"

    after_action :set_headers

    def index
      @appliances = Appliance.fetch_all
    end

    private

    def set_headers
      response.headers["cache-control"] = "no-store"
    end
  end
end
