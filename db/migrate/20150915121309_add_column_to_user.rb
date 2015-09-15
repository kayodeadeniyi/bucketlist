class AddColumnToUser < ActiveRecord::Migration
  def change
    add_column :users, :login, :boolean, default: false
  end
end
