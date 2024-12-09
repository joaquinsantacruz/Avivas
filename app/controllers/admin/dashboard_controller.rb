class Admin::DashboardController < ApplicationController
  before_action :authenticate_user!


  def redirect_based_on_auth
    if user_signed_in?
      redirect_to admin_products_path
    else
      redirect_to new_user_session_path
    end
  end
end
