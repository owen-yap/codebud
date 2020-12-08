class UsersController < ApplicationController
  # routes to new form creation page (new.html.erb)
  def new
    @user = User.new
  end
  # Creates new user instance, assigns
  def create
    @user = User.new(user_params)
    user.user_skill = user_skill
  end

  private
  def user_params
    params.require(:user).permit(:name, :email)
  end
end
