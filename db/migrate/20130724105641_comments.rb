class Comments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :content
      t.references :post
      t.references :user
    end
  end
end
