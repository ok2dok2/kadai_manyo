#テーブルスキーマ

  create_table "tasks", force: :cascade do |t|
    t.text "name", null: false
    t.text "detail"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end
