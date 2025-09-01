# frozen_string_literal: true

module UnrankedSuppliers
  class DropdownComponent < ViewComponent::Base
    def initialize(suppliers, chosen_supplier_slug: nil)
      super()
      @suppliers = suppliers
      @chosen_supplier_slug = chosen_supplier_slug
    end

    def render?
      @suppliers.present?
    end

    def call
      render CitizensAdviceComponents::Select.new(**select_params)
    end

    private

    def supplier_options
      options = [["Please select", nil]]
      options + sorted_suppliers.map do |supplier|
        [
          supplier.name,
          supplier.slug
        ]
      end
    end

    def select_params
      {
        select_options: supplier_options,
        label: dropdown_label,
        name: "id",
        type: nil,
        options: {
          value: @chosen_supplier_slug
        }
      }
    end

    def sorted_suppliers
      @suppliers.sort_by!(&:name)
    end

    def dropdown_label
      if Feature.enabled? "FF_SMALL_SUPPLIER_STARS"
        "Smaller suppliers"
      else
        "Find your supplier"
      end
    end
  end
end
