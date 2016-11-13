class TopPagesController < ApplicationController
  def home
#    @food = current_user.foods.build if logged_in?
#    @stock = current_user.stocks.build if logged_in?
    
    # if logged_in
    #   @user = current_user
    #   @stock = @user.stock.build   # userに関連した Stock.new に相当
    # end
    
    # form_for(@stock) へStockに関連したモデルのインスタンスを渡す

    redirect_to current_user if logged_in?


  end
end
