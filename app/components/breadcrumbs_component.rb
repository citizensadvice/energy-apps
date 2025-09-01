# frozen_string_literal: true

# Uses existing helper methods to create breadcrumbs using design-system component
class BreadcrumbsComponent < ViewComponent::Base
  delegate :scotland?, to: :helpers

  def initialize(current_page_title:)
    super()
    @current_page_title = current_page_title
  end

  def call
    render CitizensAdviceComponents::Breadcrumbs.new(links, type: :no_collapse)
  end

  def links
    page_breadcrumbs.unshift home_link
  end

  def home_link
    {
      title: "Home",
      url: home_url
    }
  end

  def home_url
    scotland? ? "https://www.citizensadvice.org.uk/scotland" : "https://www.citizensadvice.org.uk"
  end

  def page_breadcrumbs
    scotland? ? scotland_breadcrumbs : default_breadcrumbs
  end

  def default_breadcrumbs
    [
      { url: "https://www.citizensadvice.org.uk/consumer/", title: "Consumer" },
      { url: "https://www.citizensadvice.org.uk/consumer/energy/energy-supply/", title: "Your energy supply" },
      { title: @current_page_title }
    ]
  end

  def scotland_breadcrumbs
    [
      { url: "https://www.citizensadvice.org.uk/scotland/consumer/", title: "Consumer" },
      { url: "https://www.citizensadvice.org.uk/scotland/consumer/energy/energy-supply/", title: "Your energy supply" },
      { title: @current_page_title }
    ]
  end
end
