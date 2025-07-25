# frozen_string_literal: true

module ApplianceCalculator
  module DailyUsageCreation
    class StepsController < ApplicationController
      include WizardSteps

      self.wizard_class = ::DailyUsageCreation::Wizard

      default_form_builder ::CitizensAdviceFormBuilder::FormBuilder

      class MissingApplianceError < StandardError; end

      after_action :set_headers

      helper_method :saved_unit_rate, :usages, :usage_limit_reached?

      rescue_from MissingApplianceError, with: :handle_missing_appliance

      def show
        redirect_to step_path("completed") if usage_limit_reached?

        validate_store
        super
      end

      private

      def set_headers
        response.headers["cache-control"] = "no-store"
      end

      def step_path(step = params[:id])
        appliance_calculator_daily_usage_creation_step_path(step)
      end

      # unit rate is captured in the unit_rate step of the form, which is shown
      # only once during the first journey then saved into the session
      def saved_unit_rate
        session[:unit_rate]
      end

      def wizard_store_key
        :daily_usage_creation
      end

      def on_complete(results)
        results => { usage:, rate: }

        session[:unit_rate] = rate
        session[:usages] ||= []
        session[:usages] << usage.to_h
        flash.notice = "#{usage.label} added to list below"

        redirect_to appliance_calculator_daily_usage_creation_step_path("completed")
      end

      def usages
        return if session[:usages].blank?

        session[:usages].sort_by { |usage| usage["kwh_per_month"] }.reverse
      end

      def usage_limit_reached?
        return false if usages.blank?

        usages.size >= 10
      end

      def validate_store
        # nothing to validate on the first or completed step
        return if %w[appliance completed].include?(current_step.key)

        raise MissingApplianceError if session.dig("daily_usage_creation", "added_appliance").blank?
      end

      def handle_missing_appliance
        redirect_to step_path("appliance")
      end
    end
  end
end
