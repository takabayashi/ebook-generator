class AddTempLinkToBook < ActiveRecord::Migration
  def change
    add_column :books, :temp_link, :string
  end
end
