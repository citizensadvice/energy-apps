# frozen_string_literal: true

class FuelMixComponent < ViewComponent::Base
  attr_reader :supplier, :renderer

  delegate :contact_details_fragment, to: :helpers

  def initialize(supplier)
    super()
    @supplier = supplier
    @renderer = Renderers::RichTextRenderer.new
  end

  def render?
    supplier.present?
  end

  def descriptions
    [
      {
        term: content_tag(:h3, "Fuel Mix"),
        intro: fuel_mix_intro,
        description: fuel_mix
      }
    ].reject { |desc| desc[:description].blank? }
  end

  def fuel_mix
    renderer.render_without_breaks(supplier.fuel_mix)
  end

  def fuel_mix_intro
    content_tag(:p, "The fuel mix is the percentage of energy sources used by this supplier. #{supplier.name} uses:")
  end
end
