# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include SwiftypeMeta
  include DataLayer
  include CitizensAdviceCookiePreferences::Helpers

  def internal_server_error
    render template: "errors/500", status: :internal_server_error
  end

  def not_found
    render template: "errors/404", status: :not_found
  end
end
