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
  end
end
