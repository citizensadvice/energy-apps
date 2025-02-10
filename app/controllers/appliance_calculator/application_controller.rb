# frozen_string_literal: true

module ApplianceCalculator
  class ApplicationController < ApplicationController
    layout :choose_layout
    preserve :"no-js"

    def clear
      session[:unit_rate] = nil
      session[:usages] = nil

      redirect_to appliance_calculator_daily_usage_creation_step_path("appliance")
    end

    def choose_layout
      if params["no-js"].present?
        "appliance_calculator_no_js"
      else
        "appliance_calculator"
      end
    end
  end
end
