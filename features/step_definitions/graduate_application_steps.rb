# frozen_string_literal: true

Given(/^I am on the Graduate Applications home page$/) do
  visit graduate_applications_path
end

Given(/^I am creating a new graduate application$/) do
  visit new_graduate_application_path
end

Given(/^the following graduate applications have been submitted:/) do |application_table|
  application_table.hashes.each do |application|
    GraduateApplication.create!(application)
  end
end

When(/^I create a new education input field$/) do
  click_on 'add more'
end

Given(/^the following educations for each application:/) do |education_table|
  education_table.hashes.each do |education|
    education[:start_date] = Date.parse(education[:start_date])
    education[:end_date] = Date.parse(education[:end_date])
    education[:currently_attending] = education[:currently_attending] == 'true'

    GraduateApplication.all.each do |application|
      application.educations.create!(education)
      application.save!
    end
  end
end

Given(/I have already filled out my application personal details/) do
  fill_in 'First Name:', with: 'Elon'
  fill_in 'Last Name:', with: 'Musk'
end

Given(/I have already filled out my application contact details/) do
  fill_in 'Email:', with: 'herky@uiowa.edu'
  fill_in 'Phone:', with: '3333333333'
end

Given(/^I fill in my name as "(.*?)" "(.*?)"$/) do |first, last|
  fill_in 'First Name:', with: first
  fill_in 'Last Name:', with: last
end

And(/^I fill in my email as "(.*?)" and my phone as "(.*?)"$/) do |email, phone|
  fill_in 'Email:', with: email
  fill_in 'Phone:', with: phone
end

And(/^I fill in my school name as "(.*?)"$/) do |name|
  fill_in 'School:', with: name
end

And(/^the application's average GPA is "(\d*[.]\d*)"$/) do |gpa|
  expect(page).to have_content gpa
end

And(/^the application's name is "(.*?)" "(.*?)"$/) do |first, last|
  expect(page).to have_content "#{first} #{last}"
end

And(/^I should see the education table containing$/) do |_table|
  # table is a table.hashes.keys # => [:school_name, :start_date, :end_date, :currently_attending, :degree, :major, :gpa (4.0 scale)]
  pending
end

When(/^I sort graduate applications based on "(.*?)"$/) do |_score|
  pending
end

When(/^I submit my graduate application$/) do
  click_on 'Submit'
end

When(/^I select to view "(.*?)" "(.*?)"'s graduate application$/) do |first, last|
  all('tr').each do |tr|
    if tr.has_content? "#{first} #{last}"
      tr.click_on 'View Application'
      break
    end
  end
end

Then(/^I should see the application status "(.*?)"$/) do |status|
  expect(page.find('#status_message')).to have_content status
end

Then(/^I should see "(.*?)"'s application before "(.*?)"'s$/) do |_higher_name, _lower_name|
  pending # TODO: Check if higher_name occurs before lower_name in applications table
end
