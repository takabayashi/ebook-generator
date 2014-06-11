class AddDimensionsToBook < ActiveRecord::Migration
  def change
    add_column :books, :default_width, :int
    add_column :books, :default_height, :int
  end
end
