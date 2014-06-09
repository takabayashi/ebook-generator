class AddFilePathToBookTemplate < ActiveRecord::Migration
  def change
    add_column :book_templates, :file_path, :string
  end
end
