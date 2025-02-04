# frozen_string_literal: true

require "rails_helper"

RSpec.describe JsBuildManifestGenerator do
  describe "#generate_file_map" do
    subject(:file_map) { described_class.new.generate_file_map }

    let(:js_build_metadata) do
      {
        "outputs" => {
          "js-file-1-abcdef1234.js" => {
            "entryPoint" => "js-file-1.js"
          },
          "js-file-2-cdef6789.js" => {
            "entryPoint" => "js-file-2.js"
          },
          "js-file-1-abcdef1234.js.map" => {
            "entryPoint" => "js-file-1.js.map"
          }

        }
      }.to_json
    end

    before do
      allow(File).to receive(:read).and_return(js_build_metadata)
    end

    it "contains the key for file 1" do
      expect(file_map.keys).to include("js-file-1.js")
    end

    it "contains the key for file 2" do
      expect(file_map).to include("js-file-2.js")
    end

    it "does not contain a key for the map file" do
      expect(file_map).not_to include("js-file-1.js.map")
    end

    it "contains the correct value for the entry points" do
      expect(file_map["js-file-1.js"]).to eq "js-file-1-abcdef1234.js"
    end
  end
end
