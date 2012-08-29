class GamesController < ApplicationController
  @actionpage = ""
  @cateid = ""
  
  def index
    @actionpage = "index"
    @games_hot_banner = Game.game_hot.limit(3)
    @per_page = 2
    
    if params[:category].nil?
      params[:category] = "all"
    end
    
    if params[:game] == "hot"
      if params[:category] != "all"
        @cateid = params[:category]
        @games = Game.where(:category_id => params[:category]).game_hot.page(params[:page]).per(@per_page)
      else
        @games = Game.game_hot.page(params[:page]).per(@per_page)
      end
    elsif params[:game] == "top"
      if params[:category] != "all"
        @cateid = params[:category]
        @games = Game.where(:category_id => params[:category]).top_rated
      else
        @games = Game.top_rated
      end
      @games = Kaminari.paginate_array(@games).page(params[:page]).per(@per_page)
    else
      if params[:category] != "all"
        @cateid = params[:category]
        @games = Game.where(:category_id => params[:category]).game_new.page(params[:page]).per(@per_page)
      else
        @games = Game.game_new.page(params[:page]).per(@per_page)
      end
    end
  end

  def search
    @actionpage = "index"
    @games_hot_banner = Game.game_hot.limit(3)
    @per_page = 5
    
    if params[:search_text].present?
      @games = Game.fulltext_search(params[:search_text], { :max_results => 100 })
      @games = Kaminari.paginate_array(@games).page(params[:page]).per(@per_page)
    else
      redirect_to root_path
    end
  end
  
  def show
    @actionpage = "show"
    @game = Game.find(params[:id])
    @comments = @game.comments
    @comment = current_user.comments.build if signed_in?
    @game_images = @game.game_images
  end

  def rating
    # binding.pry
    @game = Game.find(params[:id])
    if Rate.where(game_id: @game.id, user_id: current_user.id).count == 1
      @rate = Rate.where(game_id: @game.id, user_id: current_user.id).first
      @rate.update_attribute(:value, params[:value])
    else
      @rate = @game.rates.build
      @rate.value = params[:value]
      @rate.user_id = current_user.id
      @rate.save
    end
    redirect_to show_path(:id => @game.id)
  end
end
