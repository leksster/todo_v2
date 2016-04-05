require 'rails_helper'
require 'faker'

feature "Visiting the homepage", js: true do
  let(:user) {create(:user)}
  let(:project) {create(:project, user: user)}
  let(:task) {create(:task, project: project)}
  let(:comment) {create(:comment, task: task)}

  background do
    login_as(user)
    project
    task
    comment
    visit root_path
  end

  scenario "User can CREATE Comments" do
    commentText = Faker::Hipster.sentence(10)
    puts user.id
    puts project.user.id
    within('.tasks', text: task.text) do
      find('a', text: task.text).click
      find("input[placeholder='Comment text...'").set(commentText)
    end
    click_button 'Add Comment'
  end

  scenario "User can READ Comments" do
    within('.tasks', text: task.text) do
      find('a', text: task.text).click
    end
    expect(page).to have_content(task.text)
    expect(page).to have_content(comment.text)
  end

  scenario "User can UPDATE Comments" do
    newText = Faker::Hipster.sentence(5)
    within('.tasks', text: task.text) do
      find('a', text: task.text).click
      find('blockquote').hover
      find('.updateComment').click
    end
  end

  scenario "User can DELETE Comments" do
    within('.tasks', text: task.text) do
      find('a', text: task.text).click
      find('blockquote').hover
      find('.removeComment').click
    end
    expect(page).not_to have_content(comment.text)
  end

  # scenario "User can READ Tasks" do
  #   expect(page).to have_content(project.name)
  #   expect(page).to have_content(task.text)
  # end

  # scenario "User can UPDATE Tasks" do
  #   newText = Faker::Hipster.sentence(5)
  #   find('.content-box').hover
  #   find('.editTask').click
  #   within('.modal-body') do
  #     find('input').set(newText)
  #   end
  #   within('.modal-footer') do
  #     find('.btn-primary').click
  #   end
  #   expect(page).to have_content(newText)
  # end

  # scenario "User can DELETE Tasks" do
  #   find('.content-box').hover
  #   find('.removeTask').click
  #   expect(page).not_to have_content(task.text)
  # end
end