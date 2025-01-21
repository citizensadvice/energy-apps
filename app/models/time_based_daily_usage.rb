# frozen_string_literal: true

class TimeBasedDailyUsage
  include ActiveModel::Model

  attr_writer :appliance_name,
              :wattage,
              :appliance_quantity,
              :minutes_used,
              :additional_usage

end
