class AddAccessTypeToUserRoles < ActiveRecord::Migration[6.0]
  def change
    add_column :user_roles, :access_type, :string
  end
end
