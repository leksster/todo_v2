require 'rails_helper'
require 'faker'

feature "Tasks features", js: true do
  let(:user) {create(:user)}
  let(:project) {create(:project, user: user)}
  let(:task) {create(:task, project: project)}

  background do
    login(user)
    project
    task
  end

  after { visit '/'; Capybara.reset_session! }

  scenario "User can CREATE Tasks" do
    taskText = Faker::Hipster.sentence(7)
    within('.form-box') do
      find('input').set(taskText)
      click_button "Add Task"
    end
    expect(page).to have_content(taskText)
  end

  scenario "User can READ Tasks" do
    sleep(3)
    expect(page).to have_content(project.name)
    expect(page).to have_content(task.text)
  end

  scenario "User can UPDATE Tasks" do
    newText = Faker::Hipster.sentence(5)
    find('.content-box').hover
    find('.editTask').click
    within('.modal-body') do
      find('input').set(newText)
    end
    within('.modal-footer') do
      find('.btn-primary').click
    end
    expect(page).to have_content(newText)
  end

  scenario "User can DELETE Tasks" do
    find('.content-box').hover
    find('.removeTask').click
    sleep(3)
    expect(page).not_to have_content(task.text)
  end
end