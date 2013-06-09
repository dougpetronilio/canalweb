class FavoritoController < ApplicationController
  def index
    @title = "Meus canais favoritos"
    @favoritos = Favorito.all(:conditions => ["user_profile_id = ?", current_user.user_profile.id])

  end

  def adicionar
    @canal = Canal.find(params[:canal_id])
    @favorito = Favorito.new
    @favorito.canal = @canal
    @favorito.user_profile = current_user.user_profile
    @favorito.save
    redirect_to :controller => "/canals", :action => "show", :id => @canal.id
  end

  def deletar
    @favorito = Favorito.find(params[:favorito_id])
    @canal = @favorito.canal
    @favorito.destroy
    redirect_to :controller => "/canals", :action => "show", :id => @canal.id
  end

end
