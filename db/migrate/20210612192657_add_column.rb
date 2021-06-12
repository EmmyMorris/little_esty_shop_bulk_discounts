class AddColumn < ActiveRecord::Migration[5.2]
  def change
    add_column :discounts, :name, :string
  end
end
