require 'rails_helper'

RSpec.describe "Tasks", type: :system do
  context 'ログイン前' do
    it '新規作成ページのアクセスが失敗すること' do
      visit new_task_path
      expect(current_path).to eq(login_path)
    end
  end

  describe 'ログイン後' do
    let(:user){create(:user)}

    before do
      login(user)
    end

    context 'フォームの入力値が正常' do
      it 'タスクの作成が成功' do
        visit new_task_path
        expect{
          fill_in 'Title', with: 'タイトル'
          fill_in 'Content', with: 'コンテンツ'
          select 'todo', from: 'Status'
          fill_in 'Deadline',with: 1.week.from_now
          click_on 'Create Task'
        }.to change{Task.count}.by(1)
        expect(current_path).to eq(task_path(Task.first))
        expect(page).to have_content('Task was successfully created.')
      end
    end
  end
end
