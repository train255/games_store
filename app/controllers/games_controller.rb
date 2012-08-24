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
