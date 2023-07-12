require 'rails_helper'
RSpec.describe '検索機能', type: :system do
  describe '新規作成機能' do
    let!(:user2){FactoryBot.create(:user2)}
    let!(:label){FactoryBot.create(:label)}
    #let!(:task){FactoryBot.create(:task)}
    #let!(:tasklabel){FactoryBot.create(:tasklabel)}
    it '作成したタスクのラベルを表示させる' do
      visit new_session_path
      fill_in 'session[email]', with: 'admin1@gmail.com'
      fill_in 'session[password]', with: 'pass'
      click_on 'Login'
      visit new_task_path
      fill_in "task[name]", with: "テスト1"
      fill_in "task[detail]", with: "テスト1"
      fill_in "task[date]", with: "2023-07-03"
      select '完了', from: 'task[status]'
      select '高', from: 'task[priority]'
      check 'MyString'
      click_on "タスクを作成する"
      expect(page).to have_content 'MyString'
    end
    it 'ラベルで検索ができる' do
      visit new_session_path
      fill_in 'session[email]', with: 'admin1@gmail.com'
      fill_in 'session[password]', with: 'pass'
      click_on 'Login'
      click_on 'タスクを登録する'
      fill_in "task[name]", with: "テスト1"
      fill_in "task[detail]", with: "テスト1"
      fill_in "task[date]", with: "2023-07-03"
      select '完了', from: 'task[status]'
      select '高', from: 'task[priority]'
      check 'MyString'
      click_on "タスクを作成する"
      select 'MyString', from: 'label_id'
      click_on "検索"
      expect(page).to have_content 'MyString'
    end
  end
  describe 'ラベル作成する' do
    let!(:user2){FactoryBot.create(:user2)}
    # let!(:task){FactoryBot.create(:task)}
    # let!(:tasklabel){FactoryBot.create(:tasklabel)}
    it '作成したタスクのラベルを表示させる' do
      visit new_session_path
      fill_in 'session[email]', with: 'admin1@gmail.com'
      fill_in 'session[password]', with: 'pass'
      click_on 'Login'
      click_on "管理者ページ"
      click_on "タグ一覧"
      fill_in "label[title]", with: "MyString111"
      click_on 'タグ作成'
      expect(page).to have_content 'MyString111'
    end
  end
end