require 'rails_helper'

feature 'Happy path' do
  scenario 'Guest user registers, sees the tracks and votes one' do
    visit '/users/sign_up'

    fill_in 'Email'                 , with: 'guest@test.com'
    fill_in 'Password'              , with: 'mypassword'
    fill_in 'Password confirmation' , with: 'mypassword'

    click_button 'Sign up'

    expect(page).to have_text('Welcome! You have signed up successfully')
  end
end
