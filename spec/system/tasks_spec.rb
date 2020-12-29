require 'rails_helper'

RSpec.describe "Tasks", type: :system do
  context 'ログイン前' do
    it '新規作成ページのアクセスが失敗すること' do
      visit new_task_path
      expect(current_path).to eq(login_path)
    end
  end
end
