require 'rails_helper'

RSpec.describe "Users", type: :system do
  describe 'ログイン前' do
    context 'フォームの入力値が正常' do
      it 'ユーザーの新規作成が成功する' do
        visit '/users/new'
        expect {
          fill_in 'Email', with: 'example@example.com'
          fill_in 'Password', with: '12345678'
          fill_in 'Password confirmation', with: '12345678'
          click_button 'SignUp'
        }.to change { User.count }.by(1)
        expect(page).to have_content('User was successfully created.')
      end
    end

    context 'メールアドレスが未入力' do
      it 'ユーザーの新規作成が失敗する' do
        visit '/users/new'
        expect {
          fill_in 'Password', with: '12345678'
          fill_in 'Password confirmation', with: '12345678'
          click_button 'SignUp'
        }.to change { User.count }.by(0)
      end
    end

    context '登録済みのメールアドレスを使用' do
      it 'ユーザーの新規作成が失敗する' do
        user = create(:user)
        visit '/users/new'
        expect {
          fill_in 'Email', with: user.email
          fill_in 'Password', with: '12345678'
          fill_in 'Password confirmation', with: '12345678'
          click_button 'SignUp'
        }.to change { User.count }.by(0)
      end
    end
  end

  describe 'マイページ' do
    context 'ログインしていない状態' do
      it 'マイページへのアクセスが失敗する' do
        user = create(:user)
        visit user_path(user)
        expect(current_path).to eq(login_path)
      end
    end
  end

  describe 'ログイン後' do
    describe 'ユーザー編集' do
      context 'フォームの入力値が正常' do
        it 'ユーザーの編集が成功する' do
          user = create(:user)
          login_user(user)
          visit edit_user_path(user)
          fill_in 'Email', with: 'editexample@example.com'
          fill_in 'Password', with: '12345678'
          fill_in 'Password confirmation', with: '12345678'
          click_button 'Update'
          expect(current_path).to eq(user_path(user))
          expect(page).to have_content('User was successfully updated.')
        end
      end
    end
  end
end
