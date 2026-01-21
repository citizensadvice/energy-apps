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
