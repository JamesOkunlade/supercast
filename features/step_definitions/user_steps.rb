# features/step_definitions/user_steps.rb

Given('I am on the login page') do
  visit '/login'
end

When('I fill in the login form') do
  fill_in 'Email', with: 'user@example.com'
  fill_in 'Password', with: 'password'
end

And('I click the submit button') do
  click_button 'Log in'
end

Then('I should see my podcasts') do
  expect(page).to have_content 'Podcast'
end
