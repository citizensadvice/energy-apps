# frozen_string_literal: true

module CsrTable
  class LocationSwitcherComponent < ViewComponent::Base
    attr_reader :current_country

    def initialize(current_country:)
      super()

      @current_country = current_country || "england"
      @available_country_urls = available_country_urls
    end

    def localised_current_country
      localise_country(@current_country)
    end

    def country_urls
      @available_country_urls.reject { |country| country == @current_country }
    end

    def country_links
      links = country_urls.map do |country, url|
        link_to url, class: "location-switcher__link" do
          tag.span("See advice for ", class: "cads-sr-only") + localise_country(country)
        end
      end
      safe_join(links, ", ")
    end

    def render?
      @available_country_urls.present?
    end

    private

    def localise_country(country)
      {
        england: "England",
        scotland: "Scotland",
        wales: "Wales"
      }.fetch(country.to_sym)
    end

    def available_country_urls
      {
        "england" => CSR_APP_PATH,
        "scotland" => "/scotland#{CSR_APP_PATH}",
        "wales" => "/wales#{CSR_APP_PATH}"
      }
    end
  end
end
