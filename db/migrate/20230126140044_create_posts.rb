class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :body
      t.datetime :publish_date, null: false

      t.timestamps
    end
  end
end
