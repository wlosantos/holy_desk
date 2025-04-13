class MembersController < ApplicationController
  before_action :set_member, only: %i[ show edit update destroy ]

  # GET /members
  def index
    @members = Member.all
  end

  # GET /members/1
  def show
  end

  # GET /members/new
  def new
    @member = Member.new
  end

  # GET /members/1/edit
  def edit
  end

  # POST /members
  def create
    @member = Member.new(member_params)

    if @member.save
      redirect_to @member, notice: "Member was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /members/1
  def update
    if @member.update(member_params)
      redirect_to @member, notice: "Member was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /members/1
  def destroy
    @member.destroy!
    redirect_to members_path, notice: "Member was successfully destroyed.", status: :see_other
  end

  def invite
    current_tenant = Tenant.first
    email = params.expect(:email)
    user_from_email = User.find_by(email: email)

    if user_from_email.present?
      if Member.exists?(user: user_from_email, tenant: current_tenant)
        redirect_to members_path, alert: "The organization #{current_tenant.name} already has #{email} as a member."
      else
        Member.create!(user: user_from_email, tenant: current_tenant)
        redirect_to members_path, notice: "#{email} was added to the tenant is #{current_tenant.name}."
      end
    elsif user_from_email.nil?
      new_user = User.invite!(email: email)
      Member.create!(user: new_user, tenant: current_tenant)

      redirect_to members_path, notice: "#{email} was invite to join the tenant is #{current_tenant.name}."
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_member
      @member = Member.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def member_params
      params.expect(member: [ :user_id, :tenant_id ])
    end
end
