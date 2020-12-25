require 'rails_helper'

RSpec.describe Task, type: :model do
  describe 'validation' do
    it '全ての属性が有効であること' do
      task = build(:task)
      expect(task).to be_valid
      expect(task.errors).to be_empty
    end

    it 'タイトルがない場合無効となること' do
      task_without_title = build(:task, title:"")
      expect(task_without_title).to be_invalid
      expect(task_without_title.errors[:title]).to eq ["can't be blank"]
    end

    it 'ステータスがない場合無効となること' do
      task_without_status = build(:task, status: nil)
      expect(task_without_status).to be_invalid
      expect(task_without_status.errors[:status]).to eq ["can't be blank"]
    end

    it '重複するタイトルの場合無効となること' do
      task = create(:task)
      task_with_duplicated_title = build(:task, title: task.title)
      expect(task_with_duplicated_title).to be_invalid
      expect(task_with_duplicated_title.errors[:title]).to eq ["has already been taken"]
    end

    it 'タイトルが重複しない場合有効となること' do
      task = create(:task)
      task_with_another_title = build(:task, title: 'another_title')
      expect(task_with_another_title).to be_valid
    end
  end
end
