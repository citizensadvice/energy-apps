# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Suppliers" do
  context "when visiting the suppliers route" do
    context "when no country is specified" do
      around do |example|
        VCR.use_cassette("supplier/suppliers-index", match_requests_on: [:body]) do
          get CSR_APP_PATH # defined in routes.rb
          example.run
        end
      end

      it "responds successfully to the suppliers route" do
        expect(response).to have_http_status :successful
      end

      it "renders the swiftype search type advice metatag" do
        expect(response.body).to include("<meta class='swiftype' content='advice' data-type='string' name='search_type_filter'>")
      end

      it "renders the correct page title" do
        expect(response.body).to include("<title>Compare energy suppliers&#39; customer service - Citizens Advice</title>\n")
      end

      it "renders the swiftype search type everything metatag" do
        expect(response.body).to include("<meta class='swiftype' content='everything' data-type='string' name='search_type_filter'>")
      end

      it "renders the swiftype audience england metatag" do
        expect(response.body).to include("<meta class='swiftype' content='england' data-type='string' name='audience_filter'>")
      end

      it "contains the correct canonical url" do
        expect(response.body).to include("<link href='https://www.citizensadvice.org.uk#{CSR_APP_PATH}' rel='canonical'>")
      end
    end

    context "when the country is Scotland" do
      around do |example|
        VCR.use_cassette("supplier/suppliers-index-scotland", match_requests_on: [:body]) do
          get "/scotland#{CSR_APP_PATH}"
          example.run
        end
      end

      it "responds successfully to the suppliers route" do
        expect(response).to have_http_status :successful
      end

      it "renders the swiftype audience scotland metatag" do
        expect(response.body).to include("<meta class='swiftype' content='scotland' data-type='string' name='audience_filter'>")
      end

      it "contains the correct canonical url" do
        expect(response.body).to include("<link href='https://www.citizensadvice.org.uk/scotland#{CSR_APP_PATH}' rel='canonical'>")
      end
    end

    context "when the country is Wales" do
      around do |example|
        VCR.use_cassette("supplier/suppliers-index-wales", match_requests_on: [:body]) do
          get "/wales#{CSR_APP_PATH}"
          example.run
        end
      end

      it "responds successfully to the suppliers route" do
        expect(response).to have_http_status :successful
      end

      it "renders the swiftype audience wales metatag" do
        expect(response.body).to include("<meta class='swiftype' content='wales' data-type='string' name='audience_filter'>")
      end

      it "contains the correct canonical url" do
        expect(response.body).to include("<link href='https://www.citizensadvice.org.uk/wales#{CSR_APP_PATH}' rel='canonical'>")
      end
    end

    context "when an invalid country is requested" do
      it "responds correctly to the suppliers route" do
        get "/france#{CSR_APP_PATH}"

        expect(response).to have_http_status :not_found
      end

      it "renders a 404 for an invalid path" do
        get "/france#{CSR_APP_PATH}/invalid-path"

        expect(response).to have_http_status :not_found
      end
    end

    context "when handling invalid paths" do
      it "renders 404 for an invalid path with no country specified" do
        get "#{CSR_APP_PATH}/invalid-path"

        expect(response).to have_http_status :not_found
      end

      it "renders 404 for an invalid path when the country is Scotland" do
        get "/scotland#{CSR_APP_PATH}/invalid-path"

        expect(response).to have_http_status :not_found
      end

      it "renders 404 for an invalid path when the country is Wales" do
        get "/wales#{CSR_APP_PATH}/invalid-path"

        expect(response).to have_http_status :not_found
      end
    end

    context "when handling 500s" do
      before do
        allow(Supplier).to receive(:fetch_all).and_return([])
        # rubocop:disable RSpec/AnyInstance
        allow_any_instance_of(SuppliersController).to receive(:index).and_raise(Contentful::GraphqlAdapter::QueryError)
        get CSR_APP_PATH
        # rubocop:enable RSpec/AnyInstance
      end

      it "renders the 500 error page" do
        expect(response).to render_template("errors/500")
      end

      it "returns status 'server error'" do
        expect(response).to have_http_status(:server_error)
      end
    end
  end

  describe "supplier details page" do
    context "when no country is specified" do
      around do |example|
        VCR.use_cassette("supplier/big-energy-inc-details-page", match_requests_on: [:body]) do
          get "#{CSR_APP_PATH}big-energy-inc/details"
          example.run
        end
      end

      it "renders the correct page title" do
        expect(response.body).to include("<title>Big Energy Inc customer service performance - Citizens Advice</title>\n")
      end

      it "renders the swiftype search type everything metatag" do
        expect(response.body).to include("<meta class='swiftype' content='everything' data-type='string' name='search_type_filter'>")
      end

      it "renders the swiftype search type advice metatag" do
        expect(response.body).to include("<meta class='swiftype' content='advice' data-type='string' name='search_type_filter'>")
      end

      it "renders the swiftype audience england metatag" do
        expect(response.body).to include("<meta class='swiftype' content='england' data-type='string' name='audience_filter'>")
      end

      it "contains the correct canonical url" do
        canonical_url = "<link href='https://www.citizensadvice.org.uk#{CSR_APP_PATH}big-energy-inc/details/' rel='canonical'>"

        expect(response.body).to include(canonical_url)
      end

      it "responds successfully to the supplier details route" do
        expect(response).to have_http_status :successful
      end
    end

    context "when the country is Scotland" do
      around do |example|
        VCR.use_cassette("supplier/big-energy-inc-details-page-scotland", match_requests_on: [:body]) do
          get "/scotland#{CSR_APP_PATH}big-energy-inc/details"
          example.run
        end
      end

      it "renders the swiftype audience scotland metatag" do
        expect(response.body).to include("<meta class='swiftype' content='scotland' data-type='string' name='audience_filter'>")
      end

      it "contains the correct canonical url" do
        canonical_url = "<link href='https://www.citizensadvice.org.uk/scotland#{CSR_APP_PATH}big-energy-inc/details/' rel='canonical'>"
        expect(response.body).to include(canonical_url)
      end

      it "responds successfully to the supplier details route" do
        expect(response).to have_http_status :successful
      end
    end

    context "when the country is Wales" do
      around do |example|
        VCR.use_cassette("supplier/big-energy-inc-details-page-wales", match_requests_on: [:body]) do
          get "/wales#{CSR_APP_PATH}big-energy-inc/details"
          example.run
        end
      end

      it "renders the swiftype audience wales metatag" do
        expect(response.body).to include("<meta class='swiftype' content='wales' data-type='string' name='audience_filter'>")
      end

      it "contains the correct canonical url" do
        canonical_url = "<link href='https://www.citizensadvice.org.uk/wales#{CSR_APP_PATH}big-energy-inc/details/' rel='canonical'>"
        expect(response.body).to include(canonical_url)
      end

      it "responds successfully to the supplier details route" do
        expect(response).to have_http_status :successful
      end
    end

    context "when an invalid country is requested" do
      it "responds correctly to a valid supplier detail route" do
        get "/france#{CSR_APP_PATH}big-energy-inc/details"

        expect(response).to have_http_status :not_found
      end

      it "responds correctly to an invalid supplier detail route" do
        get "/france#{CSR_APP_PATH}/invalid-supplier/details"

        expect(response).to have_http_status :not_found
      end
    end

    context "when handling invalid suppliers" do
      it "renders 404 for an invalid supplier when no country is specified" do
        VCR.use_cassette("supplier/details-page-not-found", match_requests_on: [:body]) do
          get "#{CSR_APP_PATH}/invalid-supplier/details"

          expect(response).to have_http_status :not_found
        end
      end

      it "renders 404 for an invalid supplier when the country is Scotland" do
        VCR.use_cassette("supplier/details-page-not-found-scotland", match_requests_on: [:body]) do
          get "/scotland#{CSR_APP_PATH}/invalid-supplier/details"

          expect(response).to have_http_status :not_found
        end
      end

      it "renders 404 for an invalid supplier when the country is Wales" do
        VCR.use_cassette("supplier/details-page-not-found-wales", match_requests_on: [:body]) do
          get "/wales#{CSR_APP_PATH}/invalid-supplier/details"

          expect(response).to have_http_status :not_found
        end
      end
    end

    context "when handling 500s" do
      before do
        allow(Supplier).to receive(:fetch_with_top_three).and_return([])
        # rubocop:disable RSpec/AnyInstance
        allow_any_instance_of(SuppliersController).to receive(:show).with(any_args).and_raise(Contentful::GraphqlAdapter::QueryError)
        get "#{CSR_APP_PATH}/big-energy-inc/details"
        # rubocop:enable RSpec/AnyInstance
      end

      it "renders the 500 error page" do
        expect(response).to render_template("errors/500")
      end

      it "returns status 'server error'" do
        expect(response).to have_http_status(:server_error)
      end
    end
  end
end
