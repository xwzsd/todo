require 'rails_helper'

RSpec.describe TodoComment, type: :model do
	describe 'validation' do
		it { should validate_presence_of :todo_task }
		it { should validate_presence_of :body }
	end

	describe 'associations' do
		it { should belong_to :todo_task }
		it { should hav_many(:todo_attachments).dependent(:destroy) }
	end

	describe 'todo_attachments' do
		before do
			@todo_comment = create(:todo_comment)
		end
	end
end
