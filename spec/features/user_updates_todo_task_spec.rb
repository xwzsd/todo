feature 'User updates a todo_task' do
  given!(:user) { create(:user) }
  given!(:todo_list) { create(:todo_list, user: user) }
  given!(:todo_task) { create(:todo_task, todo_list: todo_list) }

  background do
    sign_in(user)
  end

  scenario 'User updates a todo_task content by double click', js: true do
    expect(page).to have_content todo_task.content
    find("#todo_task-#{todo_task.id} .view").double_click
    fill_in 'edit-todo_task', with: 'new task'
    find('#edit-todo_task').native.send_keys(:return)
    expect(page).to have_content 'new task'
  end

  scenario 'User updates a todo_task content by button click', js: true do
    expect(page).to have_content todo_task.content
    find("#todo_task-#{todo_task.id}").hover
    find("#edit-todo_task-#{todo_task.id}").click
    fill_in 'edit-todo_task', with: 'new task'
    find("#edit-todo_task-#{todo_task.id}").click
    expect(page).to have_content 'new task'
  end
end
  