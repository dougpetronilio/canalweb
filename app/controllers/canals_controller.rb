class CanalsController < ApplicationController
  # GET /canals
  # GET /canals.json
  def index
    @title = "Meus Canais"
    @canals = Canal.find(:all, :conditions => ["user_id = ?", current_user.id])
    #@canals = Canal.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @canals }
    end
  end

  def buscar
    @title = "Procurar Canal"
    if params[:texto] != nil
      @canals = Canal.all(:conditions => ["nome like ? or descricao like ?", "%#{params[:texto]}%", "%#{params[:texto]}%"])
    end
  end

  # GET /canals/1
  # GET /canals/1.json
  def show
    @title = "Pagina do canal"
    @canal = Canal.find(params[:id])

    @favoritos = Favorito.all(:conditions => ["user_profile_id = ? and canal_id = ?", current_user.user_profile.id, @canal.id])
    @favorito = nil
    @favoritos.each do |f|
      @favorito = f
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @canal }
    end
  end

  # GET /canals/new
  # GET /canals/new.json
  def new
    @title = "Criar Canal"
    @canal = Canal.new
    @canal.user_id = current_user.id

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @canal }
    end
  end

  # GET /canals/1/edit
  def edit
    @title = "Editar Canal"
    @canal = Canal.find(params[:id])
  end

  # POST /canals
  # POST /canals.json
  def create
    @canal = Canal.new(params[:canal])
    @canal.user_id = current_user.id

    respond_to do |format|
      if @canal.save
        format.html { redirect_to @canal, notice: 'Canal was successfully created.' }
        format.json { render json: @canal, status: :created, location: @canal }
      else
        format.html { render action: "new" }
        format.json { render json: @canal.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /canals/1
  # PUT /canals/1.json
  def update
    @canal = Canal.find(params[:id])
    @canal.user_id = current_user.id

    respond_to do |format|
      if @canal.update_attributes(params[:canal])
        format.html { redirect_to @canal, notice: 'Canal was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @canal.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /canals/1
  # DELETE /canals/1.json
  def destroy
    @canal = Canal.find(params[:id])
    @canal.destroy

    respond_to do |format|
      format.html { redirect_to canals_url }
      format.json { head :ok }
    end
  end

end
