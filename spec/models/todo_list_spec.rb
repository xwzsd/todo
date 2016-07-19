require 'rails_helper'

RSpec.describe TodoList, type: :model do
	describe 'validation' do
		it { should validate_presence_of :user }
		it { should validate_presence_of :title }
	end

	describe 'assoviations' do
		it { should belong_to :user }
		it { should have_many(:todo_tasks).dependent(:destroy) }
	end
end
