ActiveRecord::Schema.define(version: 2023_10_17_000000) do

    create_table "guests", id: :string, limit: 36, force: :cascade do |t|
      t.string "id_book", limit: 36, null: false
      t.string "name"
      t.integer "age"
      t.string "doc_type"
      t.string "doc_num"
      t.datetime "created_at", precision: 6, null: false
      t.datetime "updated_at", precision: 6, null: false
      t.index ["id_book"], name: "index_guests_on_id_book"
    end
  
    create_table "tickets", id: :string, limit: 36, force: :cascade do |t|
      t.string "id_guest", limit: 36, null: false
      t.string "name"
      t.integer "age"
      t.string "doc_type"
      t.string "doc_num"
      t.string "category"
      t.datetime "date"
      t.integer "price"
      t.datetime "created_at", precision: 6, null: false
      t.datetime "updated_at", precision: 6, null: false
      t.index ["id_guest"], name: "index_tickets_on_id_guest"
    end
  
  end