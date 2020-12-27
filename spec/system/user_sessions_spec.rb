require 'rails_helper'

RSpec.describe "UserSessions", type: :system do
  describe 'ログイン前', focus: true do
    context 'フォームの入力値が正常' do
      it 'ログインが成功する' do
        user = create(:user)
        visit '/login'
        fill_in 'Email', with: user.email
        fill_in 'Password', with: 'password'
        click_button 'Login'
        expect(current_path).to eq '/'
        expect(page).to have_content('Login successful')
      end
    end

    context 'フォームが未入力' do
      it 'ログイン処理が失敗する' do
        user = create(:user)
        visit '/login'
        click_button 'Login'
        expect(current_path).to eq '/login'
        expect(page).to have_content('Login failed')
      end
    end
  end
end
