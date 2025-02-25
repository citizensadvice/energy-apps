# frozen_string_literal: true

module DailyUsageCreation
  module Validators
    class TimeUsageValidator < ActiveModel::Validator
      attr_accessor :record

      MAX_HOURS_IN_A_WEEK = 24 * 7

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
        case record.frequency
        when "daily"
          validate_max_daily_hours
        else
          validate_max_weekly_hours
        end
      end

      def validate_max_daily_hours
        return if record.hours.blank?

        if empty_minutes?
          record.errors.add(:base, "Enter 24 hours or fewer") if record.hours > 24
        elsif record.hours > 23
          record.errors.add(:base, "Enter 23 hours or fewer")
        end
      end

      def validate_max_weekly_hours
        if empty_minutes?
          record.errors.add(:base, "Enter #{MAX_HOURS_IN_A_WEEK} hours or fewer") if record.hours > MAX_HOURS_IN_A_WEEK
        elsif record.hours > (MAX_HOURS_IN_A_WEEK - 1)
          record.errors.add(:base, "Enter #{MAX_HOURS_IN_A_WEEK - 1} hours or fewer")
        end
      end

      def empty_hours?
        record.hours.blank? || record.hours.zero?
      end

      def empty_minutes?
        record.minutes.blank? || record.minutes.zero?
      end
    end
  end
end
