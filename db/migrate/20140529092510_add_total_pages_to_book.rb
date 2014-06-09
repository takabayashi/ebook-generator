class AddTotalPagesToBook < ActiveRecord::Migration
  def change
    add_column :books, :total_pages, :string
  end
end
