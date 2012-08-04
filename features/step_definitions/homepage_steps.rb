When /^I visit the home page$/ do
  visit '/'
end

Then /^I should be welcomed$/ do
  page.should have_content 'Welcome to SauceLabs.tv'
end

