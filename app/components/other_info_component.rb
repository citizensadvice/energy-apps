# frozen_string_literal: true

class OtherInfoComponent < ViewComponent::Base
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
        term: content_tag(:h2, "Customer service contact details for #{supplier.name}", { id: contact_details_fragment, tabindex: -1 }),
        description: contact_info
      },
      {
        term: content_tag(:h3, "Opening Hours"),
        description: opening_hours
      },
      {
        term: content_tag(:h3, "Ways to contact"),
        description: other_contact_info
      },
      {
        term: content_tag(:h3, "Payment Information"),
        description: billing_info
      }
    ].reject { |desc| desc[:description].blank? }
  end

  def contact_info
    renderer.render_with_breaks(supplier.contact_info)
  end

  def other_contact_info
    renderer.render_with_breaks(supplier.other_contact_info)
  end

  def opening_hours
    renderer.render_with_breaks(supplier.opening_hours)
  end

  def billing_info
    renderer.render_with_breaks(supplier.billing_info)
  end
end
