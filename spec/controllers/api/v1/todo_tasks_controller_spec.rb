require 'rails_helper'

RSpec.describe Api::V1::TodoTasksController, type: :controller do
	sign_in_user
	add_ability

	let!(:todo_list) { create(:todo_list, user: @user) }

	describe 'GET #index' do
		let!(:todo_tasks) {create_list(:todo_task, 3, todo_list: todo_list) }

		context 'cancan authorizes index' do
			before do
				@ability.cannot :read, TodoTask
				get :index, todo_list_id: todo_list
			end

			it {expect(response).to be_forbidden }
		end

		it 'should return successful response' do
			get :index, format: :json, todo_list_id: todo_list
			expect(response).to be_success
		end

		it 'assigns all todo_tasks as @todo_tasks' do
			get :index, format: :json, todo_list_id: todo_list
			expect(assigns(:todo_tasks)).to match_array todo_tasks
		end
	end

	describe 'POST #create' do
		let(:todo_task) { attributes_for(:todo_task, todo_list: todo_list) }

		context 'cancan authorizes create' do
			before do
				@ability.cannot :create, TodoTask
				post :create, format: :json, todo_list_id: todo_list, content: todo_task[:content]
			end

			it { expect(response).to be_forbidden }
		end

		describe 'with valid attributes' do
			it 'it creates a todo_task' do
				expect { post :create, format: :json, todo_list_id: todo_list,
					content: todo_task[:content] }.to change(TodoTask, :count).by(1)
			end 
		end

		describe 'with invalid attributes' do
			it 'doesnt create a todo_task' do
				expect { post :create, format: :json, todo_list_id: todo_list, content: ''}.
				to_not change(TodoTask, :count)
			end 


			it 'returns an error 422' do
				post :create, format: :json, todo_list_id: todo_list, content: ''
				expect(response.status).to eq 422
			end
		end
	end

	describe 'PATCH #update' do
		let!(:todo_task) { create(:todo_task, todo_list: todo_list) }
		let(:todo_task_update) { attributes_for(:todo_task, todo_list: todo_list) }

		context 'cancan authorizes update' do
			before do
				@ability.cannot :update, TodoTask
				patch :update, format: :json, id: todo_task, todo_task: todo_task_update
			end

			it { expect(response).to be_forbidden }
		end

		describe 'with valid attributes' do
			it 'doesnt change a todo_tasks count' do
				expect { patch :update, format: :json, id: todo_task,
					content: todo_task_update[:content] }.to_not change(TodoTask, :count)
			end

			it 'updates a todo_task' do
				patch :update, format: :json, id: todo_task, content: todo_task_update[:content]
				expect(todo_task.reload.content).to eq todo_task_update[:content]
			end
		end

		describe 'with invalid attributes' do
			it 'doesnt update a todo_task' do
				patch :update, format: :json, id: todo_task, todo_task: { content: ''}
				expect(todo_task.reload.content).not_to be_empty
			end
		end
	end

	describe 'DELETE #destroy' do
		let!(:todo_task) { create(:todo_task, todo_list: todo_list) }

		context 'cancan authorizes destroy' do
			before do
				@ability.cannot :destroy, TodoTask
				delete :destroy, format: :json, id: todo_task
			end

			it { expect(response).to be_forbidden }
		end

		it 'deletes a todo_task' do
			expect{ delete :destroy, format: :json, id: todo_task }.
			to change(TodoTask, :count).by(-1)
		end
	end
end
