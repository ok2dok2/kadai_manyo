require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        visit new_task_path
        fill_in "task[name]", with: "テスト1"
        fill_in "task[detail]", with: "テスト1"
        fill_in "task[date]", with: "2023-07-03"
        select '完了', from: 'task[status]'
        click_on "タスクを作成する"
        expect(page).to have_content 'テスト1'
      end
    end
  end
  describe '一覧表示機能' do
    before do 
      FactoryBot.create(:task)
    end
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        visit tasks_path
        expect(page).to have_content "テスト1"
      end
    end
  end
  describe '詳細表示機能' do 
    let!(:task){ FactoryBot.create(:task) }
    context '任意のタスク詳細画面に遷移した場合' do
      it '該当タスクの内容が表示される' do
        visit task_path(task)
        expect(page).to have_content "タスク詳細"
      end
    end
    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
        task2 = FactoryBot.create(:task2)
        visit tasks_path
        click_on "作成順でソートする"
        sleep 1.0
        ichiran = all('.ichiran')
        expect(ichiran[0]).to have_content 'テスト2'
        expect(ichiran[1]).to have_content 'テスト1'
      end
    end
  end
  describe 'タスク管理機能', type: :system do
    describe '検索機能' do
      before do 
        FactoryBot.create(:task)
        FactoryBot.create(:task2)
      end
      context 'タイトルであいまい検索をした場合' do
        it "検索キーワードを含むタスクで絞り込まれる" do
          visit tasks_path
          fill_in "keyword", with: "テスト"
          click_on "検索"
          expect(page).to have_content "テスト"
        end
      end
      context 'ステータス検索をした場合' do
        it "ステータスに完全一致するタスクが絞り込まれる" do
          visit tasks_path
          select '完了', from: 'search'
          click_on "検索"
          expect(page).to have_content '完了'
        end
      end
      context 'タイトルのあいまい検索とステータス検索をした場合' do
        it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
          visit tasks_path
          fill_in "keyword", with: "テスト"
          select '完了', from: 'search'
          click_on "検索"
          expect(page).to have_content '完了'
          expect(page).to have_content 'テスト'
        end
      end
    end
  end
end