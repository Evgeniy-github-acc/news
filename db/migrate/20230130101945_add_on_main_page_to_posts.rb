class AddOnMainPageToPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :on_main_page, :boolean, default: false, null: false
  end
end
