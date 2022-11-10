Given /^I am on the Graduate Applications home page$/ do
  visit graduate_applications_path
end

Given /^I am on the new graduate applications page$/ do
  visit new_graduate_application_path
end

Given /the following graduate applications have been submitted:/ do |application_table|
  application_table.hashes.each do |application|
    # TODO: create application objects to populate test DB
  end
end

Given /^I fill in my name as "(.*?)" "(.*?)"$/ do |first, last|
  pending # TODO Fill in name of form
end

And /^I fill in my GPA with "(\d*[.]\d*)"$/ do |gpa|
  pending # TODO FIll in gpa of form
end

And /^the application's GPA is "(\d*[.]\d*)"$/ do |gpa|
  pending # TODO: Check if GPA match found
end

And /^the application's name is "(.*?)" "(.*?)"$/ do |first, last|
  pending # TODO: Check if names match found
end

When /^I sort graduate applications based on "(.*?)"$/ do |score|
  click_on score
end

When /^I submit my graduate application$/ do
  click_on 'submit'
end

Then /^I should see the application status "(.*?)"$/ do |status|
  pending # TODO: Check if status match found
end

Then /^I should see "(.*?)"'s application before "(.*?)"'s$/ do |higher_name, lower_name|
  pending # TODO: Check if higher_name occurs before lower_name in applications table
end
