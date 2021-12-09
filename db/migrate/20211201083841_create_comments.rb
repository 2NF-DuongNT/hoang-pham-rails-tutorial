class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.text :content
      t.references :user, null: false, foreign_key: true
      t.references :micropost, null: false, foreign_key: true
      t.references :parent_comment, null: true

      t.timestamps
    end
    add_index :comments, [:user_id,:micropost_id,:create_at]
  end
end
