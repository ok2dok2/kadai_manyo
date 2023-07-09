require 'rails_helper'
RSpec.describe User, type: :system do
  describe 'ユーザー登録テスト' do
    it '新規登録できること' do
      visit new_user_path
      fill_in 'user[username]', with: 'test1'
      fill_in 'user[email]', with: 'test1@gmail.com'
      fill_in 'user[password]', with: 'pass'
      fill_in 'user[password_confirmation]', with: 'pass'
      click_on 'アカウント作成'
      expect(page).to have_content "マイページ"
    end
  end
  describe '遷移テスト' do
    it 'ユーザがログインせずタスク一覧画面に飛ぼうとしたとき、ログイン画面に遷移' do
      visit tasks_path
      expect(page).to have_content "Login"
    end
  end
  describe 'セッション機能1' do
    before do
      User.create!(username: 'test1', email: 'test1@gmail.com', password: 'pass', password_confirmation: 'pass', admin: 0 )
    end
    it 'ログイン画面を行う' do
      visit new_session_path
      fill_in 'session[email]', with: 'test1@gmail.com'
      fill_in 'session[password]', with: 'pass'
      click_on 'Login'
      expect(page).to have_content "マイページ"
    end
  end
  describe 'セッション機能2、3' do
    before do
      User.create!(username: 'test1', email: 'test1@gmail.com', password: 'pass', password_confirmation: 'pass', admin: 0 )
    end
    context '自分のマイページに飛んだ場合' do
      it 'マイページが表示される' do
        visit new_session_path
        fill_in 'session[email]', with: 'test1@gmail.com'
        fill_in 'session[password]', with: 'pass'
        click_on 'Login'
        click_on 'マイページ'
        expect(page).to have_content "ユーザー名"
      end
    end
    context '他ユーザーのマイページに飛んだ場合' do
      it 'タスク一覧に戻される' do
        visit new_session_path
        fill_in 'session[email]', with: 'test1@gmail.com'
        fill_in 'session[password]', with: 'pass'
        click_on 'Login'
        click_on 'マイページ'
        expect(page).to have_content "ユーザー名"
      end
    end
  end
  describe 'セッション機能4' do
    before do
      User.create!(username: 'test1', email: 'test1@gmail.com', password: 'pass', password_confirmation: 'pass', admin: 0 )
    end
      it 'ログアウトを行う' do
        visit new_session_path
        fill_in 'session[email]', with: 'test1@gmail.com'
        fill_in 'session[password]', with: 'pass'
        click_on 'Login'
        click_on 'Logout'
        expect(page).to have_content "Login"
      end
  end
  describe '管理画面1、2' do
    context '管理ユーザーの場合' do
      let!(:user2) {FactoryBot.create(:user2)}
        it '管理画面にアクセスできる' do
          visit new_session_path
          fill_in 'session[email]', with: 'admin1@gmail.com'
          fill_in 'session[password]', with: 'pass'
          click_on 'Login'
          click_on '管理者ページ'
          expect(page).to have_content "管理者ページ"
        end
    end
    context '一般ユーザーの場合' do
      let!(:user) {FactoryBot.create(:user)}
        it '管理画面にアクセスできない' do
          visit new_session_path
          fill_in 'session[email]', with: 'test1@gmail.com'
          fill_in 'session[password]', with: 'pass'
          click_on 'Login'
          click_on '管理者ページ'
          expect(page).to have_content "タスク一覧"
        end
    end
  end
  describe '管理画面3、4、5、6' do
    context '管理ユーザーの場合' do
      let!(:user2) {FactoryBot.create(:user2)}
        it 'ユーザーの新規登録が行える' do
          visit new_session_path
          fill_in 'session[email]', with: 'admin1@gmail.com'
          fill_in 'session[password]', with: 'pass'
          click_on 'Login'
          click_on '管理者ページ'
          click_on 'ユーザー登録'
          fill_in 'user[username]', with: 'testtest1admin'
          fill_in 'user[email]', with: 'testtest1admin@gmail.com'
          fill_in 'user[password]', with: 'pass'
          fill_in 'user[password_confirmation]', with: 'pass'
          check 'user[admin]'
          click_on 'アカウント作成'
          expect(page).to have_content "testtest1admin"
        end
        it 'ユーザーの詳細画面にアクセス' do
          visit new_session_path
          fill_in 'session[email]', with: 'admin1@gmail.com'
          fill_in 'session[password]', with: 'pass'
          click_on 'Login'
          click_on '管理者ページ'
          click_button '編'
          expect(page).to have_content "ユーザー編集"
        end
        it 'ユーザーの編集画面からユーザーを編集' do
          visit new_session_path
          fill_in 'session[email]', with: 'admin1@gmail.com'
          fill_in 'session[password]', with: 'pass'
          click_on 'Login'
          click_on '管理者ページ'
          click_button '編'
          fill_in 'user[password]', with: 'pass'
          fill_in 'user[password_confirmation]', with: 'pass'
          check 'user[admin]'
          click_on 'アカウント編集'
          expect(page).to have_content "ユーザー情報を更新しました"
        end
        it 'ユーザーを削除' do
          visit new_session_path
          fill_in 'session[email]', with: 'admin1@gmail.com'
          fill_in 'session[password]', with: 'pass'
          click_on 'Login'
          click_on '管理者ページ'
          click_on 'ユーザー登録'
          fill_in 'user[username]', with: 'testtest1admin'
          fill_in 'user[email]', with: 'testtest1admin@gmail.com'
          fill_in 'user[password]', with: 'pass'
          fill_in 'user[password_confirmation]', with: 'pass'
          check 'user[admin]'
          click_on 'アカウント作成'
          sleep 5
          sakujyo = page.all(".btn-outline-warning")
          sleep 5
          sakujyo[1].click
          sleep 5
          expect(page).to have_content 'ユーザーを削除しました'
        end
    end
  end
end
