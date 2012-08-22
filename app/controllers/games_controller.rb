class GamesController < ApplicationController
  @actionpage = ""
  @cateid = ""
  
  def index
    @actionpage = "index"
    @games_hot_banner = Game.game_hot.limit(3)
    if params[:game] == "hot"
      if params[:category]
        @cateid = params[:category]
        @games = Game.where(:category_id => params[:category]).game_hot.page(params[:page]).per(2)
      else
        @games = Game.game_hot.page(params[:page]).per(2)
      end
    else
      if params[:category]
        @cateid = params[:category]
        @games = Game.where(:category_id => params[:category]).game_new.page(params[:page]).per(2)
      else
        @games = Game.game_new.page(params[:page]).per(2)
      end
    end
  end

  def show
    @actionpage = "show"
    @game = Game.find(params[:id])
    @comments = @game.comments
    @comment = current_user.comments.build if signed_in?
    @game_images = @game.game_images
  end

  def test_orastream_widget
    render 'test_orastream_widget', layout: false
  end

  def rate_game
    # binding.pry
    render text: "Successfully"
  end
end
