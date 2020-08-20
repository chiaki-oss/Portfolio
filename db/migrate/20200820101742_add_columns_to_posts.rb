class AddColumnsToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :postal_code, :string
    add_column :posts, :address, :string
  end
end
