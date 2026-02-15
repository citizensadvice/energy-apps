# frozen_string_literal: true

module CsrTable
  class SuppliersController < ApplicationController
    class SupplierNotFoundError < StandardError; end

    include SwiftypeMeta
    include Cacheable

    rescue_from SupplierNotFoundError, with: :not_found
    rescue_from Contentful::GraphqlAdapter::QueryError, with: :internal_server_error

    before_action :set_supplier, only: :show
    before_action :set_suppliers, :set_unranked_supplier, :set_next_quarter_release, only: :index
    before_action :set_quarter_date, only: %i[index show]
    before_action :set_page_meta_tags, :set_swiftype_meta_tags

    attr_accessor :supplier, :unranked_supplier, :quarter_date, :next_quarter_release

    helper_method :supplier, :ranked_suppliers, :unranked_suppliers, :unranked_supplier, :supplier_with_top_three, :quarter_date,
                  :next_quarter_release

    QUARTER_DATE_CONTENT_ID = "3OdGRuiq5a99kVxYpQQklF"
    NEXT_QUARTER_RELEASE_CONTENT_ID = "230w36VUwaerIjibJYFoSG"

    def index; end 

    def show
      raise SupplierNotFoundError, "Cannot find supplier with id #{params[:id]}" unless @supplier
    end

    private

    def permitted_params
      params.permit(:id)
    end

    # sets the supplier used in the supplier detail page
    def set_supplier
      @supplier = supplier_with_top_three.find { |s| s.slug == permitted_params[:id] }
    end

    # sets all supplier array used in the main suppliers table page
    def set_suppliers
      @suppliers = Supplier.fetch_all
    end

    def ranked_suppliers
      @suppliers.select(&:data_available)
    end

    def unranked_suppliers
      @suppliers.reject(&:data_available)
    end

    def set_unranked_supplier
      return if permitted_params[:id].blank?

      @unranked_supplier = unranked_suppliers.find { |s| s.slug == permitted_params[:id] }
      raise SupplierNotFoundError, "Cannot find unranked supplier with id #{params[:id]}" unless @unranked_supplier
    end

    def supplier_with_top_three
      @supplier_with_top_three ||= Supplier.fetch_with_top_three(permitted_params[:id])
    end

    def set_quarter_date
      # passes in contentful id for quarter dates content
      @quarter_date = QuarterDate.fetch_quarter_dates_content(QUARTER_DATE_CONTENT_ID)
    end

    def set_next_quarter_release
      # passes in contentful id for next quarter date content
      @next_quarter_release = QuarterDate.fetch_quarter_dates_content(NEXT_QUARTER_RELEASE_CONTENT_ID)
    end

    def set_swiftype_meta_tags
      add_swiftype_meta([
        { name: "search_type_filter", content: "everything", type: "string" },
        { name: "search_type_filter", content: "advice", type: "string" },
        { name: "audience_filter", content: helpers.current_country || "england", type: "string" }
      ])
    end

    def set_page_meta_tags
      # meta tags are set by the meta-tags gem.  See https://github.com/kpumuk/meta-tags
      # Use existing Episerver path for favicon and touch icon

      set_meta_tags(
        title: meta_title,
        description: meta_description,
        icon: [
          { href: "apple-touch-icon.png", rel: "apple-touch-icon", type: "image/png" }
        ]
      )
    end

    def meta_title
      return "Compare energy suppliers' customer service" if supplier.blank?

      "#{supplier.name} customer service performance"
    end

    def meta_description
      # rubocop:disable Layout/LineLength
      if supplier.blank?
        "Don’t switch before you compare customer services. Large energy companies ranked by number of complaints, wait times and commitments. Check your supplier."
      else
        "Customer service contact details and scores for #{supplier.name}. Find out how well #{supplier.name} customer service performs and how to contact them."
      end
      # rubocop:enable Layout/LineLength
    end

    def custom_data_layer_properties
      if supplier.blank?
        {
          pageTemplate: "Energy Customer Service Ratings Table",
          pageType: "Energy Customer Service Ratings Table",
          GUID: "energy-csr-table"
        }
      else
        {
          pageTemplate: "Energy Customer Service Ratings - #{supplier.name}",
          pageType: "Energy Customer Service Ratings - #{supplier.name}",
          GUID: "energy-csr-#{supplier.slug}"
        }
      end
    end
  end
end
