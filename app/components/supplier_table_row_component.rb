# frozen_string_literal: true

class SupplierTableRowComponent < ViewComponent::Base
  attr_reader :supplier

  def initialize(supplier, highlight: false)
    @supplier = supplier
    @highlight = highlight
  end

  def highlight?
    @highlight
  end

  def apply_top_border?
    !supplier.top_three? && highlight?
  end

  def row_classes
    classes = %w[supplier-table__row]
    classes << "supplier-table__row--highlight" if highlight?
    classes << "supplier-table__row--top-border" if apply_top_border?
    classes
  end

  def render_overall_score
    if highlight?
      render ScoreComponent.new(score: supplier.overall_rating, show_decimal_score: true)
    else
      render ScoreComponent.new(score: supplier.overall_rating, show_decimal_score: true).with_content(link_to("More details", supplier))
    end
  end
end
