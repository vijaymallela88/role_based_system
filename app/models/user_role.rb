class UserRole < ApplicationRecord
  validates_presence_of :user_id, :role_id
end
