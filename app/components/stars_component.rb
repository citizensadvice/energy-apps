# frozen_string_literal: true

class StarsComponent < ViewComponent::Base
  MAX_SCORE = 5

  attr_reader :score

  def initialize(score:, highlight_stars: false)
    super()
    @highlight_stars = highlight_stars
    @score = score
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
    half_stars.times { star_list << :half }
    empty_stars.times { star_list << :empty }

    star_list
  end

  def half_stars
    return 0 unless @highlight_stars

    score_decimal = @score.to_s.split(".").last

    score_decimal.to_i < 5 ? 0 : 1
  end

  def render_star(star)
    case star
    when :full
      render Star::FullComponent.new
    when :half
      render Star::HalfComponent.new
    else
      render Star::EmptyComponent.new
    end
  end
end
