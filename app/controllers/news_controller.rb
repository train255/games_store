class NewsController < ApplicationController
  @actionpage = ""
  
  def index
    
  end
  
  def show
    @actionpage = "index"

    @games_hot_banner = Game.game_hot.limit(3)
    @news = News.find(params[:news])
  end
end
