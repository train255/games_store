class StaticPagesController < ApplicationController
  def home
    @games_hot = Game.game_hot
  end

  def help
  end

  def about
  end

  def contact
  end
end
