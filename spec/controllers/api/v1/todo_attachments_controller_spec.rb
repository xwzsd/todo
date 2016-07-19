require 'rails_helper'

RSpec.describe Api::V1::TodoAttachmentsController, type: :controller do
	sign_in_user
	add_ability

	let!(:todo_list) { create(:todo_list, user: @user) }
	let!(:todo_task) { create(:todo_task, todo_list: todo_list) }
	let!(:todo_comment) { create(:todo_comment, todo_task: todo_task) }

	describe 'POST #create' do
		let(:todo_attachment) {attributes_for(:todo_attachment, todo_comment: todo_comment)}
		context 'cancan authorizes create' do
			before do
				@ability.cannot :create, Attachment
				post :create, format: :json, todo_comment_id: todo_comment,
				  attachment: attachment['file']
			end

			it { expect(response).to be_forbidden }
		end

		describe 'with valid attributes' do
			it 'creates an todo_attachment' do
				expect { post :create, format: :json, todo_comment_id: todo_comment,
					file: todo_attachment[:file] }.to change(TodoAttachment, :count).by(1)
			end
		end

		describe 'with invalid attributes' do
			it 'doesnt create an todo_attachment' do
				expect { post :create, format: :json, todo_comment_id: todo_comment, file: nil}.
				  to_not change(TodoAttachment, :count)
			end

			it 'returns an error 422' do
				post :create, format: :json, todo_comment_id: todo_comment, file: nil
				expect(response.status).to eq 422
			end
		end
	end
end
