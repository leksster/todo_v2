require 'rails_helper'
require 'faker'

feature "Comments features", js: true do

  background do
    @user = create(:user)
    @project = create(:project, user: @user)
    @task = create(:task, project: @project)
    @comment = create(:comment, task: @task)
    sign_in_driver(@user)
  end

  after { visit '/'; Capybara.reset_session! }

  scenario "User can CREATE Comments" do
    
    commentText = Faker::Hipster.sentence(1)
    within('.tasks', text: @task.text) do
      find('a', text: @task.text).click
    end
    within('.comments') do
      find("input").set(commentText)
    end
    click_button 'Add Comment'
    expect(page).to have_content(commentText)
  end

  scenario "User can CREATE Comment with file attached" do 
    commentText = Faker::Hipster.sentence(1)
    within('.tasks', text: @task.text) do
      find('a', text: @task.text).click
    end
    within('.comments') do
      find("input.form-control").set(commentText)
    end
    page.execute_script("$('span.delme').children().unwrap();")
    attach_file('attach', File.absolute_path('./Rakefile'))
    click_button 'Add Comment'
    expect(page).to have_content(commentText)
    expect(page).to have_content('Rakefile')
  end

  scenario "User can READ Comments" do
    within('.tasks', text: @task.text) do
      find('a', text: @task.text).click
    end
    expect(page).to have_content(@task.text)
    expect(page).to have_content(@comment.text)
  end

  scenario "User can UPDATE Comments" do
    expect(page).to have_content(@task.text)
    newText = Faker::Hipster.sentence(5)
    within('.tasks', text: @task.text) do
      find('a', text: @task.text).click
      find('blockquote').hover
      find('.updateComment').click
      find('.editable-input').set(newText)
    end
    within('.editable-buttons') do
      find('.btn-primary').click
    end
    expect(page).to have_content(newText)
  end

  scenario "User can DELETE Comments" do
    within('.tasks', text: @task.text) do
      find('a', text: @task.text).click
      find('blockquote').hover
      find('.removeComment').click
    end
    expect(page).not_to have_content(@comment.text)
  end
end