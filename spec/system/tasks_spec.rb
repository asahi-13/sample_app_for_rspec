require 'rails_helper'

RSpec.describe "Tasks", type: :system do
  let(:user) {create(:user)}
  let(:task) {create(:task)}

  describe 'ログイン前' do
    describe 'ページ遷移確認'do
      context 'タスクの新規登録ページにアクセス' do
        it '新規登録ページへのアクセスが失敗する' do
          visit new_task_path
          expect(page).to have_content('Login required')
          expect(current_path).to eq login_path
        end
      end

      context 'タスクの編集ページにアクセス' do
        it '編集ページへのアクセスが失敗する' do
          visit edit_task_path(task)
          expect(page).to have_content('Login required')
          expect(current_path).to eq login_path
        end
      end
    end
  end
  describe 'ログイン後' do

    before do
      login_as(user)
      visit new_task_path
    end

    context 'フォームの入力値が正常' do
      it 'タスクの作成が成功' do
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

    context 'タイトルが未入力' do
      it 'タスクの作成が失敗' do
        expect{
          fill_in 'Title', with: ''
          fill_in 'Content', with: 'コンテンツ'
          select 'todo', from: 'Status'
          fill_in 'Deadline',with: 1.week.from_now
          click_on 'Create Task'
        }.to change{Task.count}.by(0)
        expect(current_path).to eq(tasks_path)
        expect(page).to have_content("Title can't be blank")
      end
    end

    # context '重複したタイトルの場合' do
    #   it 'タスクの作成が失敗' do
    #     expect{
    #       fill_in 'Title', with: task.title
    #       fill_in 'Content', with: 'コンテンツ'
    #       select 'todo', from: 'Status'
    #       fill_in 'Deadline',with: 1.week.from_now
    #       click_on 'Create Task'
    #     }.to change{Task.count}.by(0)
    #     expect(current_path).to eq(tasks_path)
    #     expect(page).to have_content("Title has already been taken")
    #   end
    # end
  end
end
