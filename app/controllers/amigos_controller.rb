class AmigosController < ApplicationController
  def index
    @title = "Meus Amigos"
    @amigos = Amigo.all(:conditions => ["user_profile_id = ?", current_user.user_profile.id])
    if params[:q] != nil
      @usuarios = UserProfile.all(:conditions => ["nome like ? or sobrenome like ?", params[:q], params[:q]])
    end
  end

  def adicionar
    @usuario = UserProfile.find(params[:id])
    Amigo.requisicao(current_user.user_profile, @usuario)
    flash[:notice] = "Requisicao feita"
    redirect_to :controller => "/user_profile", :action => "profile", :id => @usuario.id
  end

  def remover
    @usuario = UserProfile.find(params[:id])
    Amigo.rejeita(current_user.user_profile, @usuario)
    flash[:notice] = "Relacionamento removido"
    redirect_to :action => "index"
  end

  def aceitar
    @usuario = UserProfile.find(params[:id])
    Amigo.aceita(current_user.user_profile, @usuario)
    flash[:notice] = "Requisicao aceitar"
    redirect_to :action => "index"
  end


end
