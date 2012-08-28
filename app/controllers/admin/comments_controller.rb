class Admin::CommentsController < Admin::ApplicationController
  layout "admin"
  def index
    @per_page = 5
    @comments = Comment.all.page(params[:page]).per(@per_page)
  end
  
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to admin_comments_path
  end
end
