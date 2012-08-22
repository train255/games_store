class StaticPagesController < ApplicationController
  @actionpage = ""
  @cateid = ""
  
  def home
    @actionpage = "home"
    @games_hot_banner = Game.game_hot.limit(3)

    if params[:category]
      @cateid = params[:category]
      @games_new = Game.where(:category_id => params[:category]).game_new.page(params[:page]).per(2)
    else
      @games_new = Game.game_new.page(params[:page]).per(2)
    end
  end
  
  def hot_game
    @actionpage = "home"
    @games_hot_banner = Game.game_hot.limit(3)
    
    if params[:category]
      @games_hot = Game.where(:category_id => params[:category]).game_hot.page(params[:page]).per(2)
      @cateid = params[:category]
    else
      @games_hot = Game.game_hot.page(params[:page]).per(2)
    end
  end
  
  def news
    @actionpage = "home"

    @games_hot = Game.game_hot.page(params[:page]).per(2)
    @news = News.find(params[:news])
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
