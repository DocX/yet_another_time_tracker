Then(/^I should see '(.+)'$/) do |text|
  page.should have_content text
end

Then(/^I should not see '(.+)'$/) do |text|
  page.should_not have_content text
end