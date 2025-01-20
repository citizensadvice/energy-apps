# frozen_string_literal: true

module DailyUsageCreation
  module Validators
    class CycleFrequencyValidator < ActiveModel::Validator
      attr_accessor :record

      def validate(record)
        @record = record
        validate_cycle_presence
        validate_cycle_number
        validate_frequency
      end

      def validate_cycle_presence
        return if record.cycles.present?

        record.errors.add(:cycle_frequency, "Enter the number of cycles you use")
      end

      def validate_cycle_number
        return if record.cycles.blank?

        return if record.cycles.match?(/\d+\z/)

        record.errors.add(:cycle_frequency, "Enter the number of cycles you use")
      end

      def validate_frequency
        return if record.frequency.present?

        record.errors.add(:cycle_frequency, "Select a frequency from the list")
      end
    end
  end
end
