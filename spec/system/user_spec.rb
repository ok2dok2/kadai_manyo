require 'rails_helper'
RSpec.describe User, type: :model do
  describe 'ユーザー登録テスト' do
    # before do
    #     User.create!(username: 'test1', emali: 'test1@gmail.com', password: 'pass', password_confirmation: 'pass', uncheck '管理者権限')
    # end
      it '新規登録できること' do
        visit new_user_path
        fill_in 'username', with: 'test1'
        fill_in 'email', with: 'test1@gmail.com'
        fill_in 'password', with: 'pass'
        fill_in 'password_confirmation', with: 'pass'
        uncheck '管理者権限'
        click_on 'アカウント作成'
        visit user_path
        expect(page).to have_content "マイページ"
      end
  end

  describe '遷移テスト' do
    # before do
    #     User.create!(username: 'test1', emali: 'test1@gmail.com', password: 'pass', password_confirmation: 'pass', uncheck '管理者権限')
    # end
      it 'ユーザがログインせずタスク一覧画面に飛ぼうとしたとき、ログイン画面に遷移' do
        visit tasks_path
        expect(page).to have_content "Login"
      end
  end

  describe 'セッション機能' do
    before do
        User.create!(username: 'test1', emali: 'test1@gmail.com', password: 'pass', password_confirmation: 'pass', admin: 0 )
    end
      it 'ログイン画面を行う' do
        visit new_session_path
        fill_in 'email', with: 'test1@gmail.com'
        fill_in 'password', with: 'pass'
        click_on 'ログイン
        expect(page).to have_content "マイページ"
      end
  end
end
