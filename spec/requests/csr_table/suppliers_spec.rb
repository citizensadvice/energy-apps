# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Suppliers" do
  describe "when visiting the suppliers route" do
    context "when no country is specified" do
      context "with valid path" do
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

        it "returns headers to allow the CDN to cache it" do
          expect(response.headers["Cache-Control"]).to eq(
            "max-age=300, public, stale-while-revalidate=60, stale-if-error=86400, s-maxage=300"
          )
        end
      end

      context "when visiting the supplier index" do
        around do |example|
          VCR.use_cassette("supplier/suppliers-index", match_requests_on: [:body]) do
            get CSR_APP_PATH # defined in routes.rb
            example.run
          end
        end

        it "renders the cookie banner" do
          expect(response.body).to include "<div class=\"cookie-banner js-cookie-banner\""
        end
      end

      context "with invalid path" do
        it "generates a 404" do
          get "#{CSR_APP_PATH}/invalid-path"

          expect(response).to have_http_status :not_found
        end
      end
    end

    context "when the country is Scotland" do
      context "with valid path" do
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

      context "with invalid path" do
        it "generates a 404" do
          get "/scotland#{CSR_APP_PATH}/invalid-path"

          expect(response).to have_http_status :not_found
        end
      end
    end

    context "when the country is Wales" do
      context "with valid path" do
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

      context "with invalid path" do
        it "generates a 404" do
          get "/wales#{CSR_APP_PATH}/invalid-path"

          expect(response).to have_http_status :not_found
        end
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

    context "when handling 500s" do
      before do
        allow(Supplier).to receive(:fetch_all).and_return([])
        # rubocop:disable RSpec/AnyInstance
        allow_any_instance_of(CsrTable::SuppliersController).to receive(:set_quarter_date).and_return([])
        allow_any_instance_of(CsrTable::SuppliersController).to receive(:set_next_quarter_release).and_return([])
        allow_any_instance_of(CsrTable::SuppliersController).to receive(:index).and_raise(Contentful::GraphqlAdapter::QueryError)
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

  describe "when searching for unranked suppliers" do
    it "responds successfully to the unranked suppliers route" do
      VCR.use_cassette("supplier/suppliers-index-unranked-supplier", match_requests_on: [:body]) do
        get "#{CSR_APP_PATH}?id=beach-kenergy"

        expect(response).to have_http_status :successful
      end
    end

    it "renders 404 for an invalid unranked supplier" do
      VCR.use_cassette("supplier/suppliers-index-unranked-supplier-not-found", match_requests_on: [:body]) do
        get "#{CSR_APP_PATH}?id=invalid-supplier"

        expect(response).to have_http_status :not_found
      end
    end
  end

  describe "when visiting the supplier details page" do
    context "when no country is specified" do
      context "with a valid supplier" do
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

      context "with an invalid supplier" do
        it "generates a 404" do
          VCR.use_cassette("supplier/details-page-not-found", match_requests_on: [:body]) do
            get "#{CSR_APP_PATH}/invalid-supplier/details"

            expect(response).to have_http_status :not_found
          end
        end
      end

      context "when FF_NEW_CSR_DATA is enabled" do
        around do |example|
          ClimateControl.modify({ FF_NEW_CSR_DATA: "true" }) do
            VCR.use_cassette("supplier/big-energy-inc-details-page", match_requests_on: [:body]) do
              get "#{CSR_APP_PATH}big-energy-inc/details"
            end
            example.run
          end
        end

        it "renders the Scores breakdown heading" do
          expect(response.body).to include("<h2>\nScores breakdown\n</h2>")
        end

        # rubocop:disable Layout/LineLength
        it "renders the More information summary" do
          expect(response.body).to include("<p>\nWe give energy suppliers a score out of 5 for each category, based on various data. You can look at this data in more detail below.\n</p>")
        end
        # rubocop:enable Layout/LineLength
      end

      context "when FF_NEW_CSR_DATA is not enabled" do
        around do |example|
          ClimateControl.modify({ FF_NEW_CSR_DATA: "false" }) do
            VCR.use_cassette("supplier/big-energy-inc-details-page", match_requests_on: [:body]) do
              get "#{CSR_APP_PATH}big-energy-inc/details"
            end
            example.run
          end
        end

        it "does not render the More Information heading" do
          expect(response.body).not_to include("<h2>\nMore information\n</h2>")
        end

        # rubocop:disable Layout/LineLength
        it "does not render the More information summary" do
          expect(response.body).not_to include("<p>\nWe give energy suppliers a score out of 5 for each category, based on various data. You can look at this data in more detail below.\n</p>")
        end
        # rubocop:enable Layout/LineLength
      end
    end

    context "when the country is Scotland" do
      context "with a valid supplier" do
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

      context "with an invalid supplier" do
        it "generates a 404" do
          VCR.use_cassette("supplier/details-page-not-found-scotland", match_requests_on: [:body]) do
            get "/scotland#{CSR_APP_PATH}/invalid-supplier/details"

            expect(response).to have_http_status :not_found
          end
        end
      end
    end

    context "when the country is Wales" do
      context "with a valid supplier" do
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

      context "with an invalid supplier" do
        it "renders 404 for an invalid supplier" do
          VCR.use_cassette("supplier/details-page-not-found-wales", match_requests_on: [:body]) do
            get "/wales#{CSR_APP_PATH}/invalid-supplier/details"

            expect(response).to have_http_status :not_found
          end
        end
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

    context "when handling 500s" do
      before do
        allow(Supplier).to receive(:fetch_with_top_three).and_return([])
        # rubocop:disable RSpec/AnyInstance
        allow_any_instance_of(CsrTable::SuppliersController).to receive(:set_quarter_date).and_return([])
        allow_any_instance_of(CsrTable::SuppliersController).to receive(:show).with(any_args).and_raise(Contentful::GraphqlAdapter::QueryError)
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
