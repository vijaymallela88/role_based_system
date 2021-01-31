class CreateUserRoles < ActiveRecord::Migration[6.0]
  def change
    create_table :user_roles do |t|
      t.integer :user_id
      t.integer :role_id
      t.integer :created_by

      t.timestamps
    end
  end
end
