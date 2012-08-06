class StaticPagesController < ApplicationController
  @actionpage = ""

  def home
    @actionpage = "home"
    @games_hot = Game.game_hot.page(params[:page]).per(2)
    @games_new = Game.game_new.page(params[:page]).per(2)
  end
  
  def hot_game
    @actionpage = "home"
    @games_hot = Game.game_hot.page(params[:page]).per(2)
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

  def test_orastream_widget
    render 'test_orastream_widget', layout: false
  end
end
