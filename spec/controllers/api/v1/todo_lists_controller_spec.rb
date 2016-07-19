require 'rails_helper'

RSpec.describe Api::V1::TodoListsController, type: :controller do

	sign_in_user
	add_ability

	describe 'GET #index' do
		let!(:todo_lists) { create_list(:todo_list, 3, user: @user) }

		context 'cancan authorizes index' do
			before do
				@ability.cannot :read, TodoList
				get :index
			end

			it { expect(response).to be_forbidden }
		end

		it 'should return successful response' do
			get :index, format: :json
			expect(response).to be_succes
		end

		it 'assigns all todo_lists as @todo_lists' do
			get :index, format: :json
			expect(assigns(:todo_lists)).to match_array todo_lists
		end
	end

	describe 'GET #show' do
		let!(:todo_list) {create(:todo_list, user: @user) }

		context 'cancan authorizes show' do
			before do
				@ability.cannot :read, TodoList
				get :show, id: todo_list
			end

			it { expect(response).to be_forbidden }
		end

		it 'assigns a todo_list as todo_list' do
			get :show, format: :json, id: todo_list
			expect(assigns(:todo_list)).to eq todo_list
		end
	end

	describe 'POST #create' do
		context 'cancan authorizes create' do
			before do
				@ability.cannot :create, TodoList
				post :create, format: :json, title: 'New todo_list'
			end

			it { expect(response).to be_forbidden }
		end

		describe 'with valid attributes' do
			it 'creates a todo_list' do
				expect { post :create, format: :json, ttile: 'New todo_list' }.
				to change(TodoList, :count).by(1)
			end
		end

		describe 'with invalid attributes' do
			it 'doesnt create a todo_list' do
				expect { post :create, format: :json, title: ''}.
				to_not change(TodoList, :count)
			end

			it 'returns an error 422' do
				post :create, format: :json, title: ''
				expect(response.status).to eq 422
			end
		end
	end

	describe 'PATCH #update' do
		let!(:todo_list) { create(:todo_list, user: @user) }
		let!(:todo_list_update) { attributes_for(:todo_list, user: @user) }

		context 'cancan authorizes update' do
			before do
				@ability.cannot :update, TodoList
				patch :update, format: :json, id: todo_list, title: todo_list_update[:title]
			end

			it { expect(response).to be_forbidden }
		end

		describe 'with valid attributes' do
			it 'doesnt change a todo_list count' do
				expect { patch :update, format: :json, id: todo_list,
					title: todo_list_update[:title] }.to_not change(TodoList, :count)
			end

			it 'update a todo_list' do
				patch :update, format: :json, id: todo_list, title: todo_list_update[:title]
				expect(todo_list.reload.title).to eq todo_list_update[:title]
			end
		end

		describe 'with invalid attributes' do
			it 'doesnt update a todo_list' do
				patch :update, format: :json, id: todo_list, title: ''
				expect(todo_list.reload.title).not_to be_empty
			end
		end
	end

	describe 'DELETE #destroy' do
		let!(:todo_list) { create(:todo_list, user: @user) }

		context 'cancan authorizes destroy' do
			before do
				@ability.cannot :destroy. TodoList
				delete :destroy, format: :json, id: todo_list
			end

			it { expect(response).to be_forbidden }
		end

		it 'deletes a todo_list' do
			expect{ delete :destroy, format: :json, id: todo_list }.
			to change(TodoList, :count).by(-1)
		end
	end
end
