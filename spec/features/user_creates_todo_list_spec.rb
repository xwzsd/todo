feature 'User creates a todo_list' do
  given!(:user) { create(:user) }

  background do
    sign_in(user)
  end

  scenario 'Add a new todo_list', js: true do
    find('#new-todo_list').click
    fill_in 'Add a new todo_list', with: 'Start todo_list'
    click_button 'Add TODO list'
    expect(page).to have_content 'Start todo_list'
  end
end
