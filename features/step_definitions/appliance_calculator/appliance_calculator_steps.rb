# frozen_string_literal: true

Given("I am on the choose an appliance step") do
  visit "/appliance-calculator"
end

When("I choose an appliance with time based usage") do
  select "TEST - Fan heater", from: "Select an appliance"
end

When("I say I have two of them") do
  fill_in "How many of these appliances do you use?", with: 2
end

When("I proceed to the next step") do
  click_button "Next"
end

Then("I am on the How much do you use the appliance step") do
  expect(page).to have_text "How long do you use TEST - Fan heater(s) for?"
end

When(/^I enter (\d+) hours$/) do |arg|
  fill_in "Hours", with: arg
end

And(/^I enter (\d+) minutes$/) do |arg|
  fill_in "Minutes", with: arg
end

And("I say I use the appliance weekly") do
  select "Week", from: "Frequency"
end

Then("I am asked how much I pay for electricity") do
  expect(page).to have_text "How much do you pay for electricity?"
end

When("I enter a unit rate") do
  fill_in "The national average rate is 24.5p/kWh.", with: 10
end

And("I confirm the rate") do
  click_button "Confirm rate and add appliance"
end

Then("I am shown a table with my chosen time based appliance") do
  expect(page).to have_gridcell "TEST - Fan heater"
  expect(page).to have_gridcell "Quantity: 2"
  expect(page).to have_gridcell "Duration: 1 hrs 30 mins"
end

And("I am shown a message showing my most recently added cyclical appliance") do
  expect(page).to have_text "TEST - Dishwasher (Eco cycle)"
end

When("I choose an appliance with cyclical usage") do
  select "TEST - Dishwasher (Eco cycle)", from: "Select an appliance"
end

Then("I am on the how many cycles do you run step") do
  expect(page).to have_text "How many cycles do you run?"
end

When(/^I enter (\d+) cycles$/) do |arg|
  fill_in "Cycles", with: arg
end

Then("I am shown a table with my chosen cyclical appliance") do
  expect(page).to have_gridcell "TEST - Dishwasher (Eco cycle), 1 cycles per week"
  expect(page).to have_gridcell "Cycle(s): 1"
end

When("I choose an appliance with cyclical usage with variants") do
  select "TEST - Tumble Dryer (condenser)", from: "Select an appliance"
end

Then("I am asked which variant I use") do
  expect(page).to have_text "How full is the tumble dryer?"
end

When("I choose a variant") do
  choose "Full load", fieldset: "How full is the tumble dryer?"
end

Then("I am shown a table with my chosen cyclical appliance with variants") do
  expect(page).to have_gridcell "TEST - Tumble Dryer (condenser), Full load, 1 cycles per day"
  expect(page).to have_gridcell "Cycle(s): 1"
  expect(page).to have_gridcell "Full load"
end

And("I am shown a message saying {string} added below") do |msg|
  expect(page).to have_text msg
end

When("I add a time based usage for {string}") do |appliance|
  select appliance, from: "Select an appliance"
  click_button "Next"
  fill_in "Hours", with: 0
  fill_in "Minutes", with: 1
  click_button "Next"
end

Then("I am shown which is the most expensive appliance I have added") do
  expect(page).to have_text "Your most expensive appliance in this list is your TEST - Fan heater"
end

When("I return to the start of the form") do
  click_button "Add another appliance"
end

Then "I am returned to the start of the form" do
  expect(page).to have_field "Select an appliance"
end

Then("I am not asked the unit rate again") do
  expect(page).to have_no_text "How much do you pay for electricity?"
end

And("I clear the list of appliances") do
  click_button "Clear list"
end

Then("The list of appliances only has the broadband router and not the fan heater") do
  expect(page).to have_gridcell "TEST - Broadband router"
  expect(page).not_to have_gridcell "TEST - Fan heater"
end

Then("I cannot return to the start of the form") do
  expect(page).to have_no_button "Add another appliance"
end

And("I am told I have added the maximum number of appliances") do
  expect(page).to have_text "You have added the maximum number of appliances"
end
