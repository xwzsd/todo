feature 'User removes todo_comment' do
  given!(:user) { create(:user) }
  given!(:todo_list) { create(:todo_list, user: user) }
  given!(:todo_task) { create(:todo_task, todo_list: todo_list) }
  given!(:todo_comment) { create(:todo_comment, todo_task: todo_task) }

  background do
    sign_in(user)
  end

  scenario 'Authorized user removes a todo_comment', js: true do
    find("#todo_task-#{todo_task.id}").hover
    find("#todo_comment-todo_task-#{todo_task.id}").click
    expect(page).to have_content todo_comment.body
    find("#todo_comment-#{todo_comment.id}").hover
    find("#del-todo_comment-#{todo_comment.id}").click
    expect(page).to_not have_content todo_comment.body
  end
end
