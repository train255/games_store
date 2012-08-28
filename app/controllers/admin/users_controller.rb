class Admin::UsersController < Admin::ApplicationController
  layout "admin"
  def index
    if params[:search_text].present?
      @users = User.fulltext_search(params[:search_text], { :max_results => 100 })
    else
      @users = User.all
    end
    
    @per_page = 5
    if params[:sort_by].present?
      if params[:direction] == "asc"
        @users = @users.sort {|a, b| a[params[:sort_by].to_sym].to_s <=> b[params[:sort_by].to_sym].to_s}
      else
        @users = @users.sort {|a, b| b[params[:sort_by].to_sym].to_s <=> a[params[:sort_by].to_sym].to_s}
      end
    else
      @users = @users.sort {|a, b| a[:email].to_s <=> b[:email].to_s}
    end
    
    if @users.is_a? Array
      @users = Kaminari.paginate_array(@users).page(params[:page]).per(@per_page)
    else
      @users = @users.page(params[:page]).per(@per_page)
    end

  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    
    if @user.update_without_password(params[:user])
      redirect_to [:admin, @user], notice: 'User was successfully updated'
    else
      render action: "edit"
    end
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    
    if @user.save
      redirect_to [:admin, @user], notice: "User was successfully created."
    else
      render action: "new"
    end
  end
end
