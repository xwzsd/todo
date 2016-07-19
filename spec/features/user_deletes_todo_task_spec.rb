feature 'User removes a todo_task' do
  given!(:user) { create(:user) }
  given!(:todo_list) { create(:todo_list, user: user) }
  given!(:todo_task) { create(:todo_task, todo_list: todo_list) }

  background do
    sign_in(user)
    sleep 0.5
  end

  scenario 'Authorized user deletes a todo_task', js: true do
    expect(page).to have_content todo_task.content
    find("#todo_task-#{todo_task.id}").hover
    find("#del-todo_task-#{todo_task.id}").click
    expect(page).to_not have_content todo_task.content
  end
end
