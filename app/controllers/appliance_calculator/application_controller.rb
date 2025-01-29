# frozen_string_literal: true

module ApplianceCalculator
  class ApplicationController < ApplicationController
    def clear
      session[:unit_rate] = nil
      session[:usages] = nil

      redirect_to appliance_calculator_daily_usage_creation_step_path("appliance")
    end
  end
end
