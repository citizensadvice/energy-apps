# frozen_string_literal: true

module CsrTable
  class StarsComponent < ViewComponent::Base
    MAX_SCORE = 5

    attr_reader :score

    def initialize(score:, highlight_stars: false, half_stars: false)
      super()
      @highlight_stars = highlight_stars
      @score = score
      @half_stars = half_stars
    end

    def star_classes
      [
        "stars",
        ("stars--highlight" if @highlight_stars)
      ]
    end

    def stars
      star_list = []
      full_stars = @score.to_i
      empty_stars = MAX_SCORE - full_stars - half_stars

      full_stars.times { star_list << :full }
      half_stars.times { star_list << half_star_type }
      empty_stars.times { star_list << :empty }

      star_list
    end

    def half_stars
      return 0 unless @half_stars

      score_decimal = @score.to_s.split(".").last

      score_decimal.to_i < 5 ? 0 : 1
    end

    def half_star_type
      @highlight_stars ? :highlighted_half : :half
    end

    def render_star(star)
      case star
      when :full
        render CsrTable::Star::FullComponent.new
      when :half
        render CsrTable::Star::HalfComponent.new
      when :highlighted_half
        render CsrTable::Star::HighlightedHalfComponent.new
      else
        render CsrTable::Star::EmptyComponent.new
      end
    end
  end
end
