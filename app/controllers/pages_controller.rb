class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
    redirect_to uikit_path if user_signed_in?
  end

  def index
  end

  def account
    @user = current_user
  end
end
