# frozen_string_literal: true

Given("I am on the Energy Supplier Table page") do
  visit "/"
end

Then("I should see {string}") do |text|
  page.has_text?(text)
end