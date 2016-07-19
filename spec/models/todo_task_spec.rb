require 'rails_helper'

RSpec.describe TodoTask, type: :model do
	describe 'validation' do
		it { should validate_presence_of :todo_list }
		it { should validate_presence_of :content }
	end

	describe 'association' do
		it { should belong_to :todo_list }
		it { should have_many(:todo_comments).dependent(:destroy) }
	end
end
