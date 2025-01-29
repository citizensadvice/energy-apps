# frozen_string_literal: true

class CountryConstraint
  def initialize
    @valid_countries = [nil, "wales", "scotland"]
  end

  def matches?(request)
    valid_country?(request) && valid_format?(request)
  end

  def valid_country?(request)
    @valid_countries.include?(request.params[:country])
  end

  def valid_format?(request)
    request.format == :html
  end
end

# Requests to this app are controlled by CloudFront in the public-website-config repo
# The original request is sent to this app by CloudFront, so we need this app to respond to
# the path below.
# If the dummy page entry that represents this app is moved in Contentful, this url will need to be updated,
# a redirect added in Contentful, and the CloudFront config changed to reflect the new url.
CSR_APP_PATH = "/consumer/your-energy/get-a-better-energy-deal/compare-domestic-energy-suppliers-customer-service/"

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # All the 'web pages' should return HTML even if the client says they accept
  # any format
  defaults format: :html do
    root to: "suppliers#index"

    constraints CountryConstraint.new do
      scope "(:country)" do
        # full table page
        get CSR_APP_PATH, to: "suppliers#index", as: "suppliers"

        # details page for a ranked supplier
        get "#{CSR_APP_PATH}/:id/details", to: "suppliers#show", as: "supplier"
      end
    end

    get "/status", to: "status#index"

    namespace :appliance_calculator, path: "appliance-calculator" do
      get "/", to: redirect("/appliance-calculator/daily_usage_creation/steps/appliance")
      get "/clear", to: "application#clear", as: "clear"

      namespace :daily_usage_creation do
        resources :steps, only: %i[show update] do
          collection do
            get :completed
          end
        end
      end
    end

    constraints ->(req) { req.format == :html } do
      # Custom error handler pages, these work because
      # config.exceptions_app = routes is set in application.rb
      # which lets us define custom error handlers by defining path
      # names which match the status code
      # https://api.rubyonrails.org/classes/ActionDispatch/ShowExceptions.html
      match "/404", to: "application#not_found", via: :all
      match "/500", to: "application#internal_server_error", via: :all

      # This needs to be the final entry in the routes as a catch-all for routing errors so they're not treated as fatal errors
      match "*path", to: "application#not_found", via: :all
    end
  end
end
