require 'rails_helper'

RSpec.describe "Users", type: :system do
  describe 'ログイン前', focus: true do
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
  end
end
