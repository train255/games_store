class StaticPagesController < ApplicationController
  @actionpage = ""

  def home
    @actionpage = "home"
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
    @actionpage = "show"
    @game = Game.find(params[:id])
  end
end
