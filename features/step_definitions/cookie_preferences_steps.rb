# frozen_string_literal: true

Then("the cookie banner is rendered") do
  expect(page).to have_text("We'd also like to use additional cookies")
  expect(page).to have_no_text("It looks like you have JavaScript turned off.")
  expect(page).to have_link("find out more about the cookies we use", href: "/about-us/information/how-we-use-cookies/")
  expect(page).to have_link("Choose cookies", href: "/cookie-preferences/?ReturnUrl=http%3A%2F%2Flocalhost%3A3300%2F")
end
