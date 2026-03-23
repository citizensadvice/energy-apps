# frozen_string_literal: true

module CsrTable
  class ScoreComponent < ViewComponent::Base
    def initialize(score:, show_decimal_score: false, decimal_places: 1, highlight_stars: false, half_stars: false)
      super()
      @score = score
      @show_decimal_score = show_decimal_score
      @decimal_places = decimal_places
      @highlight_stars = highlight_stars
      @half_stars = half_stars
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

    def half_stars?
      @half_stars
    end

    def highlight_stars?
      @highlight_stars
    end

    def scored?
      score >= 0
    end

    def score_text
      scored? ? score_out_of_five : "Not scored"
    end

    def score_out_of_five
      "#{score_number} out of 5"
    end

    def score_number
      show_decimal_score? ? format("%.#{@decimal_places}f", @score) : @score.round
    end
  end
end
