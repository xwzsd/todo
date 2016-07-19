require 'rails_helper'

RSpec.describe Api::V1::TodoCommentsController, type: :controller do
	sign_in_user
	add_ability

	let!(:todo_list) { create(:todo_list, user: @user) }
	let!(:todo_task) { create(:todo_task, todo_list: todo_list) }

	describe 'GET #index' do
		let!(:todo_comments) {create_list(:todo_comment, 3, todo_task: todo_task) }

		context 'cancan authorizes index' do
			before do
				@abylity.cannot :read, TodoCommentsController
				get :index, todo_task_id: todo_task
			end

			it { expect(response).to be_forbidden }
		end

		it 'should return successful response' do
			get :index, format: :json, todo_task_id: todo_task
			expect(response).to be_succes
		end

		it 'assigns all todo_comments as @todo_comments' do
			get :index, format: :json, todo_task_id: todo_task
			expect(assigns(:todo_comments)).to match_array todo_comments
		end
	end

	describe 'POST #create' do
		let(:todo_comment) { attributes_for(:todo_comment, todo_task: todo_task) }

		context 'cancan authorizes create' do
			before do
				@abylity.cannot :create, TodoComment
				post :create, format: :json, todo_task_id: todo_task, body: todo_comment[:body]
			end

			it { expect(response).to be_forbidden }
		end

		describe 'with valid attributes' do
			it 'creates a todo_comment' do
				expect { post :create, format: :json, todo_task_id: todo_task,
				body: todo_comment[:body] }.to change(TodoComment, :count).by(1)
			end
		end

		describe 'with invalid attributes' do
			it 'doesnt create a todo_comment' do
				expect { post :create, format: :json, todo_task_id: todo_task, body: '' }.
				to_not change(TodoComment, :count)
			end

			it 'returns an error 422' do
				post :create, format: :json, todo_task_id: todo_task, body: ''
				expect(response.status).to eq 422
			end
		end
	end

	describe 'DELETE #destroy' do
		let!(:todo_comment) {create(:todo_comment, todo_task: todo_task) }

		context 'cancan authorizes destroy' do
			before do
				@abylity.cannot :destroy, TodoComment
				delete :destroy, format: :json, id: todo_comment
			end

			it { expect(response).to be_forbidden }
		end

		it 'deletes a todo_comment' do
			expect{ delete :destroy, format: :json, id: todo_comment }.
			to change(TodoComment, :count).by(-1)
		end
	end

end
