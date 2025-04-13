class Member < ApplicationRecord
  rolify
  belongs_to :user
  belongs_to :tenant

  validates :tenant_id, presence: true, uniqueness: { scope: :user_id }

  delegate :email, to: :user
  delegate :name, to: :tenant

  after_create :assign_default_role

  private

  def assign_default_role
    self.add_role(:member) if self.roles.blank?
  end
end
