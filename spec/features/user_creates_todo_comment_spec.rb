feature 'User creates todo_comment' do
  given!(:user) { create(:user) }
  given!(:todo_list) { create(:todo_list, user: user) }
  given!(:todo_task) { create(:todo_task, todo_list: todo_list) }

  background do
    sign_in(user)
  end

  scenario 'Authorized user creates a todo_comment with valid attrs', js: true do
    find("#todo_task-#{todo_task.id}").hover
    find("#todo_comment-todo_task-#{todo_task.id}").click
    fill_in 'new-todo_comment', with: 'Urgently!'
    click_button 'Add comment'
    expect(page).to have_content 'Urgently!'
  end
end
