# frozen_string_literal: true

module Renderers
  class RichTextRenderer < RichTextRenderer::Renderer
    def render_with_breaks(node)
      return if node.blank?

      # We can trust content from Contentful
      # rubocop:disable-next Rails/OutputSafety
      render(node.json).gsub("\n", "<br/>").html_safe
    end

    def render_without_breaks(node)
      return if node.blank?

      # We can trust content from Contentful
      # rubocop:disable-next Rails/OutputSafety
      render(node.json).html_safe
    end
  end
end
