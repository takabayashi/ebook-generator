class AddConfigurationsToBook < ActiveRecord::Migration
  def change
    add_column :books, :configurations, :text
  end
end
