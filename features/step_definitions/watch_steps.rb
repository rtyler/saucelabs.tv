Given /^I am an unauthenticated user$/ do
end

Given /^I have a valid Sauce Labs username and API key$/ do
  has_valid_credentials?
end

Given /^I have an invalid Sauce Labs username or API key$/ do
  invalidate!
  SauceTV::API.any_instance.stub(:recent_jobs) do
    raise SauceTV::InvalidUserCredentials
  end
end

Given /^I have recent jobs$/ do
  SauceTV::API.any_instance.stub(:recent_jobs).and_return(jobs)
  jobs.each do |job|
    SauceTV::API.any_instance.stub(:info_for).with(job['id']).and_return(job)
  end
end

When /^I try to watch videos$/ do
  visit '/watch'
end

When /^I enter my credentials$/ do
  login!
end

Then /^I should be given a list of jobs$/ do
  page.should have_content "Welcome #{username}"
  page.should have_css('#jobs li.job')
end

Then /^I should be prompted to log in with my username and API key$/ do
  page.should have_content 'Please log in with your username and API key'
end

Then /^I should be told my credentials are invalid$/ do
  page.should have_content('Your username or API key is invalid')
end
