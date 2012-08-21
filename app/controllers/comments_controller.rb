class CommentsController < ApplicationController
  def index
    @comments = Comment.all
  end 
  
  def new
    @game = Game.find(params[:game_id])
    @comment = Comment.new
  end

  def show
    @comment = Comment.find(params[:id])
  end

  def create
    @game = Game.find(params[:game_id])
    @comment = @game.comments.build(params[:comment].merge({user_id: current_user.id}))
    
    if @comment.save
      redirect_to show_path(:id => @game.id), notice: 'comment was successfully created.'
    else
      render action: "new"
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy

    redirect_to comments_url
  end
end
