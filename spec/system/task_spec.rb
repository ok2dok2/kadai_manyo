require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        visit new_task_path
        fill_in "task[name]", with: "買い物"
        fill_in "task[detail]", with: "キャベツ"
        click_on "タスクを作成する"
        expect(page).to have_content '買い物'
      end
    end
  end
  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        task = FactoryBot.create(:task, name:'ショッピング', detail:'服')
        visit tasks_path
        expect(page).to have_content "ショッピング"
      end
    end
  end
  describe '詳細表示機能' do
      context '任意のタスク詳細画面に遷移した場合' do
        it '該当タスクの内容が表示される' do
          task = FactoryBot.create(:task, name:'グランピング', detail:'肉')
          visit task_path(task.id)
          expect(page).to have_content "タスク詳細"
        end
      end
  end
end