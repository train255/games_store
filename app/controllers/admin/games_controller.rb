class Admin::GamesController < ApplicationController
  layout "admin"
 
  def index
    @games = Game.all
  end

  def show
    @game = Game.find(params[:id])
    @game_images = @game.game_images
  end

  def new
    @game = Game.new
    @game.game_images.build
  end

  def edit
    @game = Game.find(params[:id])
  end

  def create
    # binding.pry
    @game = Game.new(params[:game])

    if @game.save
      redirect_to [:admin, @game], notice: 'Game was successfully created.'
    else
      render action: "new" 
    end
  end

  def update
    @game = Game.find(params[:id])
    if @game.update_attributes(params[:game])
      redirect_to [:admin, @game], notice: 'Game was successfully updated.' 
    else
      render action: "edit" 
    end
  end

  def destroy
    @game = Game.find(params[:id])
    @game.destroy
    redirect_to admin_games_url
  end
end
