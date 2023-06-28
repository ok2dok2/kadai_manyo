require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  
  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        visit new_task_path
        fill_in "task[name]", with: "タスク1"
        fill_in "task[detail]", with: "タスク1"
        click_on "タスクを作成する"
        expect(page).to have_content 'タスク1'
      end
    end
  end
  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        task = FactoryBot.create(:task, name:'タスク1', detail:'タスク1')
        visit tasks_path
        expect(page).to have_content "タスク1"
      end
    end
  end
  describe '詳細表示機能' do
    context '任意のタスク詳細画面に遷移した場合' do
      it '該当タスクの内容が表示される' do
        task = FactoryBot.create(:task, name:'タスク1', detail:'タスク1')
        visit task_path(task.id)
        expect(page).to have_content "タスク詳細"
      end
    end
    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
        task = FactoryBot.create(:task, name:'タスク2', detail:'タスク2')
        task1 = FactoryBot.create(:task, name:'タスク3', detail:'タスク3')
        visit tasks_path
        click_on "タスクを新しい順に並び替える"
        sleep 1.0
        ichiran = all('.ichiran')
        expect(ichiran[0]).to have_content 'タスク3'
        expect(ichiran[1]).to have_content 'タスク2'
      end
    end
  end
end