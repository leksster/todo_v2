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

  scenario "User can CREATE Task with deadline" do
    taskText = Faker::Hipster.sentence(7)
    within('.form-box') do
      find('input').set(taskText)
      find('.datepick').click
    end
    within('#datepicker') do
      find('span', text: Time.now.day+3).click  
    end
    sleep(2)
    find_button("Add").click
    click_button "Add Task" 
    sleep(2)
    within('.content-box', match: :first) do
      expect(page).to have_content(Time.now.day+3)
    end
  end

  scenario "User can READ Tasks" do
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

  scenario "User can mark task as Done" do  
    find('.check-box').click
    page.evaluate_script("window.location.reload()")
    within('.check-box') do
      expect(find('input')).to be_checked
    end
  end

  scenario "User can DELETE Tasks" do
    find('.content-box').hover
    find('.removeTask').click
    expect(page).not_to have_content(task.text)
  end
end