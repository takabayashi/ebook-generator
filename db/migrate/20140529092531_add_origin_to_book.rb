class AddOriginToBook < ActiveRecord::Migration
  def change
    add_column :books, :origin, :string
  end
end
