class StaticPagesController < ApplicationController
  @homepage = false

  def home
    @homepage = true
    @games_hot = Game.game_hot
    @games_new = Game.all
    @games_new = @games_new.reverse
  end

  def help
  end

  def about
  end

  def contact
  end

  def show
    @game = Game.find(params[:id])
  end
end
