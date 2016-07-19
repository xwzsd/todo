feature 'User creates a todo_task' do
  given!(:user) { create(:user) }
  given!(:todo_list) { create(:todo_list, user: user) }

  background do
    sign_in(user)
  end

  scenario 'Add a new todo_task', js: true do
    expect(page).to have_content todo_list.title
    fill_in 'new-todo_task', with: 'start'
    click_button 'Add task'
    expect(page).to have_content 'start'
  end
end
