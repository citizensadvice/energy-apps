# frozen_string_literal: true

module JsFileHelper
  def digested_js_file_name(file_name)
    manifest = Rails.application.config.x.js_manifest

    return if manifest.blank?

    manifest[file_name]
  end
end
