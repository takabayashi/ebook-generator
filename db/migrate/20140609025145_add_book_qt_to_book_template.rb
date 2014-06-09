class AddBookQtToBookTemplate < ActiveRecord::Migration
  def change
    add_column :book_templates, :book_qt, :number
  end
end
