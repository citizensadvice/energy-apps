# frozen_string_literal: true

# Ingests the metafile created by esbuild during the JS build process
# Produces a map of entrypoint file name to built filename so that propshaft
# can look up the correct file
class JsBuildManifestGenerator
  def generate_file_map
    built_js_files.each_with_object({}) do |output, file_map|
      # output is an array of the form [output_file_name, metadata_hash]
      output_path = output.first

      # skip the .js.map files - we don't reference those in the layouts anywhere
      next unless output_path.ends_with?(".js")

      entrypoint_path = output.second["entryPoint"]
      file_map[entrypoint_path.split("/").last] = output_path.split("/").last
    end
  end

  private

  def built_js_files
    js_manifest_json = Rails.root.join("js-build-meta.json").read
    JSON.parse(js_manifest_json)["outputs"]
  end
end

begin
  Rails.application.config.x.js_manifest = JsBuildManifestGenerator.new.generate_file_map
rescue StandardError
  Rails.logger.error("Error generating JS built assets manifest")
end
