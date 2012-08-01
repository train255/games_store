class StaticPagesController < ApplicationController
  def home
    @games = Game.game_hot
  end

  def help
  end

  def about
  end

  def contact
  end
end
