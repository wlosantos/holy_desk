class UsersController < ApplicationController
  def index
    @users = User.all.order(id: :desc)
  end

  def resend_invitation
    @user = User.find_by(id: params.expect(:id))
    if @user.nil?
      redirect_to users_path, alert: "User not found"
      render :index
    end

    if @user.invitation_accepted_at?
      redirect_to users_path, alert: "User has already accepted invitation"
    else
      @user.invite!
      redirect_to users_path, notice: "Invitation resent to #{@user.email}"
    end
  end
end
