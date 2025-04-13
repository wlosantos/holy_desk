class Tenant < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  # after_create_commit -> { broadcast_tenant_count }
  # after_destroy_commit -> { broadcast_tenant_count }
  after_commit :broadcast_tenant_count, on: [ :create, :destroy ]

  private

  # usando partial
  # def broadcast_tenant_count
  #   Turbo::StreamsChannel.broadcast_replace_to(
  #     "tenant_count_channel",
  #     target: "tenant-count",
  #     partial: "tenants/tenant_count",
  #     locals: { count: Tenant.count }
  #   )
  # end

  def broadcast_tenant_count
    Turbo::StreamsChannel.broadcast_update_to(
      "tenant_count_channel",
      target: "tenant-count",
      html: Tenant.count.to_s
    )
  end
end
