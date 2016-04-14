require 'rails_helper'
require 'faker'

feature "Registation", js: true do
  let(:email) {Faker::Internet.email}
  let(:password) {Faker::Internet.password(8)}

  before { visit '#/register' }

  after { visit '/'; Capybara.reset_session! }

  scenario "Visitor can Sign Up with valid data" do
    fill_in "email", with: email
    fill_in "password", with: password
    fill_in "password_confirmation", with: password
    find('button', text: 'Sign up').click
    expect(page).to have_content("Welcome #{email}")
  end

  scenario "Visitor cannot Sign Up with invalid data" do
    fill_in "email", with: 'email'
    fill_in "password", with: 'password'
    fill_in "password_confirmation", with: 'password'
    find('button', text: 'Sign up').click
    expect(page).not_to have_content("Welcome #{email}")
    expect(page).to have_content('Sign Up')
  end
end