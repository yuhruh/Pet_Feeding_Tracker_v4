class UsersController < ApplicationController
  before_action :set_user, only: %i[edit update destroy]
  before_action :authenticated?, only: %i[edit update destroy]

  def edit
    @user = Current.user
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to users_path, notice: "Account was successfully updated." }
        format.json { render :show, status: :ok, location: users_path }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user.destroy!
    name = @user.username.split(" ").map(&:capitalize).join(" ")
    session[:user_id] = nil if @user == Current.user

    respond_to do |format|
      format.html { redirect_to "/home", status: :see_other, alert: "#{name} and all associated records were successfully deleted." }
      format.json { head :no_content }
    end
  end

  private
  def set_user
    @user = Current.user
  end

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation, :timezone)
  end
end
