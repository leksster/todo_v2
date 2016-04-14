require 'rails_helper'
require 'faker'

feature "Registation", js: true do
  let(:user) {create(:user)}
  # let(:password) {Faker::Internet.password(8)}

  before { visit '/' }

  after { visit '/'; Capybara.reset_session! }

  scenario "User can Sign In with valid data" do
    fill_in "email", with: user.email
    fill_in "password", with: user.password
    find('button', text: 'Sign in').click
    expect(page).to have_content("Hello, #{user.email.split('@')[0]}!")
  end

  scenario "User cannot Sign In with invalid data" do
    fill_in "email", with: Faker::Internet.email
    fill_in "password", with: Faker::Internet.password
    find('button', text: 'Sign in').click
    expect(page).to have_content('Invalid login credentials')
  end
end