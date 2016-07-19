require 'rails_helper'

RSpec.describe TodoAttachment, type: :model do
	describe 'validation' do
		it { should validate_presence_of :file }
		it { should validate_presence_of :todo_comment }
	end

	describe 'association' do
		it { should belong_to :todo_comment }
	end
end
