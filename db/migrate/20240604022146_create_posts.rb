class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.integer :user_id, null: false
      t.string :post_code, null: false
      t.string :prefecture_address, null: false
      t.string :city_address, null: false
      t.string :block_address, null: false
      t.text :detail, null: false
      t.integer :status, null: false, default: 0
      t.timestamps
    end
  end
end
