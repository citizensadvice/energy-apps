# frozen_string_literal: true

class DailyUsage < ActiveModel::Model
  attr_accessor :kilowatts,
                :appliance_quantity,
                :cycle_quantity
end
