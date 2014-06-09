class AddImagesPathToBook < ActiveRecord::Migration
  def change
    add_column :books, :images_path, :string
  end
end
