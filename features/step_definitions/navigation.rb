When(/^I go to the (.+)$/) do |page_name|

  path = case page_name
    when 'current allocation page'
      current_allocation_path
    end


  visit path
end
