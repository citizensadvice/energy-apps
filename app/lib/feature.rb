# frozen_string_literal: true

require "active_model/type"

# Tiny class for checking if a feature is enabled
class Feature
  def self.enabled?(flag_name)
    # Setting "false" in the cdk returns "False", which isn't classed a falsey value by ActiveModel::Type::Boolean,
    # so we need to explicitly return false in these cases
    return false if ENV.fetch(flag_name, nil) == "False"

    # Use ActiveModel's boolean type which recognises the strings 'false'/'0' etc as false values
    ActiveModel::Type::Boolean.new.cast(ENV.fetch(flag_name, nil))
  end
end
