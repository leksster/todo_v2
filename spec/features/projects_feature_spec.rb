require 'rails_helper'
require 'faker'

feature "Visiting the homepage", js: true do
  let(:user) {create(:user)}
  let(:project) {create(:project, user: user)}

  background do
    login_as(user)
    project
    visit root_path
  end

  scenario "User can CREATE Projects" do
    projectName = Faker::Hipster.sentence(5)
    click_button "Add TODO List"
    fill_in "projectNameInput", with: projectName
    click_button "OK"
    expect(page).to have_content(projectName)
  end

  scenario "User can READ Projects" do
    expect(page).to have_content(project.name)
  end

  scenario "User can UPDATE Projects" do
    newName = Faker::Hipster.sentence(5)
    find('.title-box').hover
    find('.editProject').click
    find('.editable-input').set(newName)
    within('.editable-buttons') do
      find('.btn-primary').click
    end
    expect(page).to have_content(newName)
  end

  scenario "User can DELETE Projects" do
    find('.title-box').hover
    find('.removeProject').click
    expect(page).not_to have_content(project.name)
  end
end