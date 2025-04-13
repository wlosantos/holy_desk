class Member < ApplicationRecord
  belongs_to :user
  belongs_to :tenant

  validates :tenant_id, presence: true, uniqueness: { scope: :user_id }

  delegate :email, to: :user
  delegate :name, to: :tenant
end
