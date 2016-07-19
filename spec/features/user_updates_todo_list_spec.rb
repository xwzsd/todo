feature 'User updates a project' do
  given!(:user) { create(:user) }
  given!(:todo_list) { create(:todo_list, user: user) }

  background do
    sign_in(user)
  end

  scenario 'User updates a todo_list title by double click', js: true do
    expect(page).to have_content todo_list.title
    find('.view').double_click
    fill_in 'edit-todo_list', with: 'My new todo_list'
    find('#edit-todo_list').native.send_keys(:return)
    expect(page).to have_content 'My new todo_list'
  end

  scenario 'User updates a todo_list title by button click', js: true do
    expect(page).to have_content todo_list.title
    find("#todo_list-#{todo_list.id}").hover
    find("#edit-todo_list-#{todo_list.id}").click
    fill_in 'edit-todo_list', with: 'My new todo_list'
    find("#edit-todo_list-#{todo_list.id}").click
    expect(page).to have_content 'My new todo_list'
  end
end
