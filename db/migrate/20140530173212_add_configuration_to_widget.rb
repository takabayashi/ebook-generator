class AddConfigurationToWidget < ActiveRecord::Migration
  def change
    add_column :widgets, :configuration, :string
  end
end
