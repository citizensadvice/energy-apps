# frozen_string_literal: true

module DailyUsageCreation
  module Steps
    class Appliance < WizardSteps::Step
      include Trackable

      attribute :appliance_id, :string
      attribute :quantity, :integer, default: 1
      attribute :saved_unit_rate, :float

      validates :appliance_id, presence: { message: "Select an appliance from the list" }
      validates :quantity, presence: { message: "Enter a number of appliances greater than 0, for example 1" },
                           numericality: { greater_than: 0, message: "Enter a number of appliances greater than 0, for example 1" }

      def appliances
        ::Appliance.fetch_all
      end

      def select_params
        {
          id: "daily_usage_creation_steps_appliance_appliance_id",
          label: "Select an appliance",
          name: "daily_usage_creation_steps_appliance[appliance_id]",
          select_options: select_options,
          options: {
            value: appliance_id,
            error_message: select_error_message
          }
        }
      end

      def select_options
        grouped_apps = appliances.group_by(&:category)
        options = grouped_apps.map { |group, apps| [group, apps.map { |app| [app.name, app.id] }] }
        empty_option = ["", [["", nil]]]
        options.insert(0, empty_option)
      end

      def select_error_message
        return if errors.blank?

        errors[:appliance_id].first
      end

      def selected_appliance
        appliances.find { |app| app.id == appliance_id }
      end

      def save!
        return unless valid?

        @store[:added_appliance] = selected_appliance
        @store[:cyclical?] = selected_appliance.cyclical?

        # If a unit rate has been entered previously, it will be in the session object.
        # We use `StepsController#saved_unit_rate` to access it here and add it into the
        # wizard `store`
        @store[:saved_unit_rate] = saved_unit_rate
        super
      end

      def next_button_text
        "Next"
      end
    end
  end
end
