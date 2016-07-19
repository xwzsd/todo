require 'rails_helper'
require 'cancan/matchers'

RSpec.describe Ability, type: :model do
  subject { ability }
  let(:ability) { Ability.new(user) }

  describe 'abilities of guest' do
    let(:user) { nil }

    context 'for todo_lists' do
      let(:todo_list) { create(:todo_list) }

      it { expect(ability).not_to be_able_to(:read, TodoList) }
      it { expect(ability).not_to be_able_to(:create, TodoList) }
      it { expect(ability).not_to be_able_to(:update, TodoList) }
      it { expect(ability).not_to be_able_to(:destroy, TodoList) }
    end

    context 'for todo_tasks' do
      let(:todo_task) { create(:todo_task) }

      it { expect(ability).not_to be_able_to(:read, TodoTask) }
      it { expect(ability).not_to be_able_to(:create, TodoTask) }
      it { expect(ability).not_to be_able_to(:update, TodoTask) }
      it { expect(ability).not_to be_able_to(:destroy, TodoTask) }
    end

    context 'for todo_comments' do
      let(:todo_comment) { create(:todo_comment) }

      it { expect(ability).not_to be_able_to(:read, TodoComment) }
      it { expect(ability).not_to be_able_to(:create, TodoComment) }
      it { expect(ability).not_to be_able_to(:update, TodoComment) }
      it { expect(ability).not_to be_able_to(:destroy, TodoComment) }
    end

    context 'for todo_attachments' do
      let(:todo_attachment) { create(:todo_attachment) }

      it { expect(ability).not_to be_able_to(:read, TodoAttachment) }
      it { expect(ability).not_to be_able_to(:create, TodoAttachment) }
      it { expect(ability).not_to be_able_to(:update, TodoAttachment) }
      it { expect(ability).not_to be_able_to(:destroy, TodoAttachment) }
    end
  end

  describe 'abilities of user' do
    let(:user) { create(:user) }

    context 'for todo_lists' do
      context 'created by user' do
        let(:todo_lists) { create(:todo_list, user: user) }

        it { expect(ability).to be_able_to(:read, TodoList) }
        it { expect(ability).to be_able_to(:create, TodoList) }
        it { expect(ability).to be_able_to(:update, TodoList) }
        it { expect(ability).to be_able_to(:destroy, TodoList) }
      end

      context 'created by others' do
        let(:todo_list) { create(:todo_list) }

        it { expect(ability).not_to be_able_to(:read, TodoList) }
        it { expect(ability).not_to be_able_to(:update, TodoList) }
        it { expect(ability).not_to be_able_to(:destroy, TodoList) }
      end
    end

    context 'for todo_tasks' do
      context 'created by user' do
        let!(:todo_task) { create(:todo_task, todo_list: create(:todo_list, user: user)) }

        it { expect(ability).to be_able_to(:read, TodoTask) }
        it { expect(ability).to be_able_to(:create, TodoTask) }
        it { expect(ability).to be_able_to(:update, TodoTask) }
        it { expect(ability).to be_able_to(:destroy, TodoTask) }
      end

      context 'created by others' do
        let!(:todo_task) { create(:todo_task) }

        it { expect(ability).not_to be_able_to(:read, TodoTask) }
        it { expect(ability).not_to be_able_to(:update, TodoTask) }
        it { expect(ability).not_to be_able_to(:destroy, TodoTask) }
      end
    end

    context 'for todo_comments' do
      context 'created by user' do
        let!(:todo_task) { create(:todo_task, todo_list: create(:todo_list, user: user)) }
        let!(:todo_comment) { create(:todo_comment, todo_task: todo_task) }

        it { expect(ability).to be_able_to(:read, TodoComment) }
        it { expect(ability).to be_able_to(:create, TodoComment) }
        it { expect(ability).to be_able_to(:update, TodoComment) }
        it { expect(ability).to be_able_to(:destroy, TodoComment) }
      end

      context 'created by others' do
        let!(:todo_comment) { create(:todo_comment) }

        it { expect(ability).not_to be_able_to(:read, TodoComment) }
        it { expect(ability).not_to be_able_to(:update, TodoComment) }
        it { expect(ability).not_to be_able_to(:destroy, TodoComment) }
      end
    end

    context 'for todo_attachments' do
      context 'created by user' do
        let!(:todo_task) { create(:todo_task, todo_list: create(:todo_list, user: user)) }
        let!(:todo_attachment) { create(:todo_attachment, todo_comment: create(:todo_comment,
          todo_task: task)) }

        it { expect(ability).to be_able_to(:read, TodoAttachment) }
        it { expect(ability).to be_able_to(:create, TodoAttachment) }
        it { expect(ability).to be_able_to(:update, TodoAttachment) }
        it { expect(ability).to be_able_to(:destroy, TodoAttachment) }
      end

      context 'created by others' do
        let!(:todo_attachment) { create(:todo_attachment) }

        it { expect(ability).not_to be_able_to(:read, TodoAttachment) }
        it { expect(ability).not_to be_able_to(:update, TodoAttachment) }
        it { expect(ability).not_to be_able_to(:destroy, TodoAttachment) }
      end
    end
  end
end

