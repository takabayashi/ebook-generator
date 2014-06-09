class AddPdfVersionToBook < ActiveRecord::Migration
  def change
    add_column :books, :pdf_version, :string
  end
end
