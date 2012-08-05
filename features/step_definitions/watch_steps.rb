Given /^I am an unauthenticated user$/ do
end

Given /^I have a valid Sauce Labs username and API key$/ do
  has_valid_credentials?
end


When /^I try to watch videos$/ do
  visit '/watch'
end

When /^I enter my credentials$/ do
  fill_in 'username', :with => username
  fill_in 'api_key', :with => api_key
  click_button 'Log in'
end

Then /^I should be given a list of jobs$/ do
  page.should have_content "Welcome #{username}"
  page.should have_css('#jobs li.job')
end

Then /^I should be prompted to log in with my username and API key$/ do
  page.should have_content 'Please log in with your username and API key'
end

