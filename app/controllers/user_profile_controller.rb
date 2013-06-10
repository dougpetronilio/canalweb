class UserProfileController < ApplicationController

  helper :amigos

  before_filter :authenticate_user!

  def edit
    @title = "Editar info de usuario"
    @user_profile = UserProfile.find(current_user.user_profile.id)
    if params[:user_profile] != nil
      puts "------------Parametros ok----------------"
      puts params[:user_profile]
      if current_user.user_profile.update_attributes(params[:user_profile])
        flash[:notice] = "Dados do usuario salvos"
        puts @user_profile
        redirect_to :action => "show"
      else
        @user_profile.errors.each do |msg|
          puts msg
        end
      end
    end
  end

  def show
    @title = "Perfil do usuario"
  end

  def profile
    @title = "Perfil do usuario"
    @user = UserProfile.find(params[:id])
    @canals = Canal.find(:all, :conditions => ["user_id = ?", @user.user.id])
  end

  def index
  end
end
