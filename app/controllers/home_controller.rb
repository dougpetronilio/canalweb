class HomeController < ApplicationController

  def index
    @title = "CanalWeb"
    session[:user_return_to] = '/user_profile/index'
  end

end
