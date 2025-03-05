# frozen_string_literal: true

module ApplianceCalculator
  class ApplicationController < ApplicationController
    include DataLayer

    layout :choose_layout
    preserve :"no-js"

    def index
      redirect_to appliance_calculator_daily_usage_creation_step_path("appliance", { "no-js": params["no-js"] })
    end

    def clear
      session[:unit_rate] = nil
      session[:usages] = nil

      redirect_to appliance_calculator_daily_usage_creation_step_path("appliance")
    end

    def error
      raise StandardError
    end

    def choose_layout
      return "appliance_calculator" if params["no-js"].nil?

      if params["no-js"] == "true"
        "appliance_calculator_no_js"
      else
        "appliance_calculator"
      end
    end
  end
end
