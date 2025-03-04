# frozen_string_literal: true

module DailyUsageCreation
  module Validators
    class TimeUsageValidator < ActiveModel::Validator
      attr_accessor :record

      def validate(record)
        @record = record

        validate_presence
        validate_max_minutes if record.errors.blank?
        validate_max_hours if record.errors.blank?
      end

      def validate_presence
        record.errors.add(:base, "Enter a number of hours and/or minutes") if empty_hours? && empty_minutes?
      end

      def validate_max_minutes
        record.errors.add(:base, "Enter 59 minutes or fewer") if record.minutes.present? && record.minutes > 59
      end

      def validate_max_hours
        return if record.hours.blank?

        case record.frequency
        when "daily"
          validate_max_daily_hours if empty_minutes?
          validate_max_daily_hours_with_minutes unless empty_minutes?
        else
          validate_max_weekly_hours if empty_minutes?
          validate_max_weekly_hours_with_minutes unless empty_minutes?
        end
      end

      def validate_max_daily_hours
        return unless record.hours > max_hours_in_a_day

        record.errors.add(:base, "Enter #{max_hours_in_a_day} hours or fewer")
      end

      def validate_max_daily_hours_with_minutes
        return unless record.hours > (max_hours_in_a_day - 1)

        record.errors.add(:base, "Enter #{max_hours_in_a_day - 1} hours or fewer")
      end

      def validate_max_weekly_hours
        return unless record.hours > max_hours_in_a_week

        record.errors.add(:base, "Enter #{max_hours_in_a_week} hours or fewer")
      end

      def validate_max_weekly_hours_with_minutes
        return unless record.hours > (max_hours_in_a_week - 1)

        record.errors.add(:base, "Enter #{max_hours_in_a_week - 1} hours or fewer")
      end

      def empty_hours?
        record.hours.blank? || record.hours.zero?
      end

      def empty_minutes?
        record.minutes.blank? || record.minutes.zero?
      end

      def max_hours_in_a_day
        record.quantity * 24
      end

      def max_hours_in_a_week
        record.quantity * 24 * 7
      end
    end
  end
end
