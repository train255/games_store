class Admin::GameImagesController < ApplicationController
  def index
    @game_images = gameImage.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @game_images }
    end
  end

  # GET /game_images/1
  # GET /game_images/1.json
  def show
    @game_image = gameImage.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @game_image }
    end
  end

  # GET /game_images/new
  # GET /game_images/new.json
  def new
    @game_image = gameImage.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @game_image }
    end
  end

  # GET /game_images/1/edit
  def edit
    @game_image = gameImage.find(params[:id])
  end

  # POST /game_images
  # POST /game_images.json
  def create
    @game_image = gameImage.new(params[:game_image])

    respond_to do |format|
      if @game_image.save
        format.html { redirect_to @game_image, notice: 'game image was successfully created.' }
        format.json { render json: @game_image, status: :created, location: @game_image }
      else
        format.html { render action: "new" }
        format.json { render json: @game_image.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /game_images/1
  # PUT /game_images/1.json
  def update
    @game_image = gameImage.find(params[:id])

    respond_to do |format|
      if @game_image.update_attributes(params[:game_image])
        format.html { redirect_to @game_image, notice: 'game image was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @game_image.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /game_images/1
  # DELETE /game_images/1.json
  def destroy
    @game_image = gameImage.find(params[:id])
    @game_image.destroy

    respond_to do |format|
      format.html { redirect_to game_images_url }
      format.json { head :no_content }
    end
  end
end