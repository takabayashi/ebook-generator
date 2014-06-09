class CreateBookTemplates < ActiveRecord::Migration
  def change
    create_table :book_templates do |t|
      t.string :title

      t.timestamps
    end
  end
end
