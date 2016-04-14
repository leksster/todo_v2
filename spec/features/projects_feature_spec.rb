require 'rails_helper'
require 'faker'

feature "Projects features", js: true do
  let(:user) {create(:user)}
  let(:project) {create(:project, user: user)}

  background do
    login(user)
    project
  end

  after { visit '/'; Capybara.reset_session! }

  scenario "User can READ Projects" do
    expect(page).to have_content(project.name)
  end

  scenario "User can CREATE and READ Projects" do
    projectName = Faker::Hipster.sentence(5)
    click_button "Add TODO List"
    fill_in "projectNameInput", with: projectName
    click_button "OK"
    expect(page).to have_content(projectName)
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