class AddFilePathToBook < ActiveRecord::Migration
  def change
    add_column :books, :file_path, :string
  end
end
