class MicropostsController < ApplicationController
  def index
    @microposts = Micropost.all
  end 
  
  def new
    @game = Game.find(params[:game_id])
    @micropost = Micropost.new
  end

  def show
    @micropost = Micropost.find(params[:id])
  end

  def create
    @game = Game.find(params[:game_id])
    @micropost = @game.microposts.build(params[:micropost].merge({user_id: current_user.id}))
    
    if @micropost.save
      redirect_to show_path(:id => @game.id), notice: 'micropost was successfully created.'
    else
      render action: "new"
    end
  end

  def destroy
    @micropost = Micropost.find(params[:id])
    @micropost.destroy

    redirect_to microposts_url
  end
end
