Given(/^The following account is created:$/) do |accounts|
  # table is a table.hashes.keys # => [:first_name, :last_name, :email, :password, :type]
  accounts.hashes.keys.each do |account|
    Account.create!(:first_name => account[:first_name], :last_name => account[:last_name], :email => account[:email], :password => account[:password], :account_type => account[:account_type])
  end
end

And(/^There is an empty Student Checklist is created for student with email "([^"]*)"$/) do |email|
  account = Account.find_by(email: email)
  StudentChecklist.create!(:student_id => account.id)
end


And(/^I am on the student checklist page for student with email "([^"]*)"$/) do |email|
  student = Student.find_by(email: email)
  visit student_checklist_path student.id
end

And(/^The following Student Checklist for student with email "([^"]*)":$/) do |email, items_completed|
  # table is a table.hashes.keys # => [:citizenship, :research_area, :degree_objective]
  account = Account.find_by(email: email)
  student_checklist = StudentChecklist.create!(:student_id => account.id)
  items_completed.hashes.keys.each do |item_completed|
    student_checklist[:"#{item_completed[:type]}" => item_completed[:completed].to_b]
  end
end

Then(/^I should see an empty student checklist$/) do
  all("tr").each do |item|
    button = item.find("button")
    expect(button.checked).to eql? false
  end
end

Then(/^I should see the following items have been completed:$/) do |items_completed|
  # table is a table.hashes.keys # => [:type]
  all("tr").each do |item|
    button = item.find("button")
    expect(button.checked).to eql? items_completed.hashes.keys.include?(button.label)
  end
end