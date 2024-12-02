# frozen_string_literal: true

class DailyUsage
  include ActiveModel::Model

  attr_accessor :kilowatts,
                :appliance_quantity,
                :cycle_quantity
end
