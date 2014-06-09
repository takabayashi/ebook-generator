class AddMetadataToBook < ActiveRecord::Migration
  def change
    add_column :books, :metadata, :string
  end
end
