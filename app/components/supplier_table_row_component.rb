# frozen_string_literal: true

class SupplierTableRowComponent < ViewComponent::Base
  attr_reader :supplier

  def initialize(supplier, highlight: false, current_country: nil)
    super()
    @supplier = supplier
    @highlight = highlight
    @current_country = current_country
  end

  def highlight?
    @highlight
  end

  def apply_top_border?
    !supplier.top_three? && highlight?
  end

  def row_classes
    classes = %w[supplier-table__row gtm-supplier-table-row]
    classes << "supplier-table__row--highlight" if highlight?
    classes << "supplier-table__row--top-border" if apply_top_border?
    classes
  end

  def render_overall_score
    if highlight?
      render ScoreComponent.new(score: supplier.overall_rating, show_decimal_score: true)
    else
      render ScoreComponent.new(score: supplier.overall_rating,
                                show_decimal_score: true).with_content(more_details_link)
    end
  end

  private

  def more_details_link
    link_to("More details",
            supplier_path(supplier, { country: @current_country }), class: more_details_class, "aria-label": more_details_aria_label)
  end

  def more_details_class
    "gtm-#{supplier.name.parameterize}-details"
  end

  def more_details_aria_label
    "More details about #{supplier.name}"
  end
end
