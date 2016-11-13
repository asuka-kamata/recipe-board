class UsersController < ApplicationController
  before_action :set_user, only:[:show, :edit, :update]
  before_action :logged_in_user, only:[:edit, :update]
  before_action :check_user, only:[:edit, :update]
  
  def show
    @food = current_user.foods.build if logged_in?
    @stock = current_user.stocks.build if logged_in?
    
    
    @stocks = current_user.stocks.all.order(created_at: :desc)
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end
  
  def edit
  end
  
  def update
    if @user.update_attributes(user_params)
      flash[:success] = "Profile update"
      redirect_to @user
    end
  end
  
  
  private
  def user_params
    params.require(:user).permit(:name, :email, :password, 
                                 :password_confirmation)
  end
  
  def set_user
    @user = User.find(params[:id])
  end
  
  def check_user
    if current_user != @user
      redirect_to root_path
    end
  end
  
end
