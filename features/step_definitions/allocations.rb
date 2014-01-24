Given(/^I have no current allocation$/) do
  Allocation.delete_all
end

Given(/^I have current allocation to task (.+) in the next (\d+) hours$/) do |title, until_hours|
  Allocation.create_current :name => title, :end => DateTime.now + until_hours.to_i.hours, :start => DateTime.now
end

Given(/^I have current allocation to task (.+) elapsed (\d+) hours ago$/) do |title, ago_hours|
  Allocation.create_current :name => title,
    :end => DateTime.now - ago_hours.to_i.hours,
    :start => DateTime.now - ago_hours.to_i.hours - 1.hour
end