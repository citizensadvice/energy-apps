# frozen_string_literal: true

Then("the cookie banner is rendered") do
  expect(page).to have_text("We'd also like to use some additional cookies to:")
  expect(page).to have_no_text("It looks like you have JavaScript turned off.")
  expect(page).to have_link("Find out more about how we use cookies and keep your data safe",
                            href: "/about-us/information/how-we-use-cookies/")
  expect(page).to have_link("Choose cookies", href: "/cookie-preferences/?ReturnUrl=#{CGI.escape(current_url)}")
end
