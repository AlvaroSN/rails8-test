class DropRoles < ActiveRecord::Migration[8.0]
  def change
    remove_foreign_key :users, :roles
    remove_index :users, :role_id if index_exists?(:users, :role_id)
    remove_column :users, :role_id, :integer
    drop_table :roles
  end
end
