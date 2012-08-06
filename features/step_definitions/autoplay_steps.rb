Given /^I am logged in$/ do
  login!
end

When /^I start the auto\-player$/ do
  page.should have_content('Auto-Play')
  click_link 'Auto-Play'
end

Then /^the oldest job should start playing$/ do
  last_job = jobs[-1]
  page.should have_content "Now watching: #{last_job['name']}"
end

