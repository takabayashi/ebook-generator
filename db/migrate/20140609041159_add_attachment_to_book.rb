class AddAttachmentToBook < ActiveRecord::Migration
  def change
    add_column :books, :attachment_path, :string
  end
end
