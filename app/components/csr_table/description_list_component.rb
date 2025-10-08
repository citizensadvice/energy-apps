# frozen_string_literal: true

module CsrTable
  class DescriptionListComponent < ViewComponent::Base
    renders_one :title
    renders_many :descriptions, "DescriptionComponent"

    def render?
      descriptions?
    end

    class DescriptionComponent < ViewComponent::Base
      attr_reader :term, :description, :intro

      def initialize(term:, description:, intro: nil)
        @term = term
        @description = description
        @intro = intro
      end
    end
  end
end
