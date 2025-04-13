class TenantsController < ApplicationController
  before_action :set_tenant, only: %i[ show edit update destroy ]

  # GET /tenants
  def index
    @tenants = Tenant.all.order(id: :desc)
  end

  # GET /tenants/1
  def show
  end

  # GET /tenants/new
  def new
    @tenant = Tenant.new
  end

  # GET /tenants/1/edit
  def edit
  end

  # POST /tenants
  def create
    @tenant = Tenant.new(tenant_params)

    if @tenant.save
      @tenant.members.create!(user: current_user)

      respond_to do |format|
        format.html { redirect_to @tenant, notice: "Tenant was successfully created." }
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.replace("new_tenant_form", partial: "tenants/form", locals: { tenant: Tenant.new }),
            turbo_stream.prepend("tenants-list", partial: "tenants/tenant", locals: { tenant: @tenant, in_stream: true })
          ]
        end
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /tenants/1
  def update
    if @tenant.update(tenant_params)
      redirect_to @tenant, notice: "Tenant was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /tenants/1
  def destroy
    @tenant.destroy!
    redirect_to tenants_path, notice: "Tenant was successfully destroyed.", status: :see_other
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tenant
      @tenant = Tenant.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def tenant_params
      params.expect(tenant: [ :name ])
    end
end
