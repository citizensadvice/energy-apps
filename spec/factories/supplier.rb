# frozen_string_literal: true

FactoryBot.define do
  # Use the Hashie::Mash class to mock the data we get back from Contentful
  # See https://www.rubydoc.info/gems/hashie/Hashie/Mash
  factory :supplier_data, class: "Hashie::Mash" do
    name { "An Energy Supplier Inc" }
    slug { "an-energy-supplier-inc" }
    id { slug }
    data_available { false }
    contact_rating { 2.3 }
    guarantee_rating { 3 }
    overall_rating { 4.8 }
    bill_accuracy_and_metering_rating { 4.8 }
    bills_accuracy_smart { 98.3 }
    bills_accuracy_traditional { 82.9 }
    smart_operating { 91.7 }
    contact_info { { json: JSON.parse(File.read("spec/fixtures/contact_info.json")) } }
    billing_info { { json: JSON.parse(File.read("spec/fixtures/billing_info.json")) } }
    opening_hours { { json: JSON.parse(File.read("spec/fixtures/opening_hours.json")) } }
    fuel_mix { { json: JSON.parse(File.read("spec/fixtures/fuel_mix.json")) } }
    guarantee_list { { json: JSON.parse(File.read("spec/fixtures/guarantee_list.json")) } }

    trait :ranked do
      data_available { true }
      rank { 1 }
      complaints_rating { 4 }
      complaints_rating_score { 4.3 }
      complaints_number { 172 }
      contact_time { "00:03:27" }
      contact_email { 89 }
      contact_social_media { "01:15:00" }
    end

    trait :sync_contact do
      contact_time { "00:03:27" }
      contact_email { 89 }
      contact_webchat_sync { "00:03:00" }
      contact_whatsapp_sync { "01:23:10" }
      contact_sms_sync { "04:47:00" }
      contact_in_app_sync { "00:39:16" }
      contact_portal_sync { "01:01:01" }
    end

    trait :async_contact do
      contact_time { "00:03:27" }
      contact_email { 89 }
      contact_webchat_async { 45.7 }
      contact_whatsapp_async { 89.3 }
      contact_sms_async { 99.9 }
      contact_in_app_async { 74.2 }
      contact_portal_async { 82.9 }
    end

    trait :no_sync_or_async_contact do
      contact_time { "00:03:27" }
      contact_email { 89 }
      contact_webchat_sync { nil }
      contact_whatsapp_sync { nil }
      contact_sms_sync { nil }
      contact_in_app_sync { nil }
      contact_portal_sync { nil }
      contact_webchat_async { nil }
      contact_whatsapp_async { nil }
      contact_sms_async { nil }
      contact_in_app_async { nil }
      contact_portal_async { nil }
    end

    trait :missing_fuel_mix do
      fuel_mix { nil }
    end

    trait :missing_overall_rating do
      overall_rating { nil }
    end

    trait :whitelabelled do
      whitelabel_supplier { { name: "White Label Energy Inc" } }
    end

    trait :low_ranking do
      rank { 999 }
    end
  end

  factory :supplier, class: "Supplier" do
    data  factory: :supplier_data

    trait(:ranked) do
      data factory: %i[supplier_data ranked]
    end

    trait(:sync_contact) do
      data factory: %i[supplier_data sync_contact]
    end

    trait(:async_contact) do
      data factory: %i[supplier_data async_contact]
    end

    trait(:no_sync_or_async_contact) do
      data factory: %i[supplier_data no_sync_or_async_contact]
    end

    trait(:whitelabelled) do
      data factory: %i[supplier_data whitelabelled]
    end

    trait(:missing_fuel_mix) do
      data factory: %i[supplier_data missing_fuel_mix]
    end

    trait(:missing_overall_rating) do
      data factory: %i[supplier_data missing_overall_rating]
    end

    trait(:low_ranking) do
      data factory: %i[supplier_data ranked low_ranking]
    end
  end
end
