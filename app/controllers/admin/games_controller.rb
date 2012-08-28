class Admin::GamesController < ApplicationController
  layout "admin"
 
  def index
    @per_page = 5;
    @games = Game.all.page(params[:page]).per(@per_page);
  end

  def show
    @per_page = 5
    @game = Game.find(params[:id])
    @comments = @game.comments
    @game_images = @game.game_images
  end

  def new
    @game = Game.new
    @game.game_images.build
  end

  def edit
    @game = Game.find(params[:id])
    (1 - @game.game_images.count).times { @game.game_images.build }
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
    # binding.pry
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
