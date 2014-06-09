class CreateWidgets < ActiveRecord::Migration
  def change
    create_table :widgets do |t|
      t.string :title
      t.string :full_path
      t.references :book, index: true

      t.timestamps
    end
  end
end
