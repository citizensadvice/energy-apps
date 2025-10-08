# frozen_string_literal: true

module CsrTable
  class ScoreComponent < ViewComponent::Base
    def initialize(score:, show_decimal_score: false)
      super()
      @score = score
      @show_decimal_score = show_decimal_score
    end

    def render?
      @score.present?
    end

    private

    def score
      @score.clamp(-3, 5)
    end

    def show_decimal_score?
      @show_decimal_score
    end

    def highlight_stars?
      # We only highlight the stars when a decimal score is displayed
      show_decimal_score?
    end

    def scored?
      score >= 0
    end

    def score_text
      scored? ? score_out_of_five : "Not scored"
    end

    def score_out_of_five
      return "#{score_number} out of 5" unless show_decimal_score?

      "#{score_number} out of 5"
    end

    def score_number
      show_decimal_score? ? @score.round(1) : @score.round
    end
  end
end
