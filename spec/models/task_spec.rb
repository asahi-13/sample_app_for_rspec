require 'rails_helper'

RSpec.describe Task, type: :model do
  describe 'validation' do
    it '全ての属性が有効であること' do
      task = build(:task)
      expect(task).to be_valid
    end

    it 'タイトルがない場合無効となること' do
      task = build(:task, title:"")
      expect(task).to be_invalid
    end

    it 'ステータスがない場合無効となること' do
      task = build(:task, status:nil)
      expect(task).to be_invalid
    end

    it '重複するタイトルの場合無効となること' do
      task = create(:task)
      task_duplicate = build(:task)
      expect(task_duplicate).to be_invalid
    end

    it 'タイトルが重複しない場合有効となること' do
      task = create(:task)
      other_task = build(:task, title:"test2")
      expect(other_task).to be_valid
    end
  end
end
