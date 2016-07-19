feature 'User removes a todo_list' do
  given!(:user) { create(:user) }
  given!(:todo_list) { create(:todo_list, user: user) }

  background do
    sign_in(user)
  end

  scenario 'Remove an exist todo_list', js: true do
    expect(page).to have_content todo_list.title
    find("#todo_list-#{todo_list.id}").hover
    find("#del-todo_list-#{todo_list.id}").click
    expect(page).to_not have_content todo_list.title
  end
end
