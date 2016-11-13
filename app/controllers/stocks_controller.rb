class StocksController < ApplicationController
    before_action :logged_in_user, only:[:create, :show]
    
    def show
        @user = User.find(params[:id])
        @stocks = @user.stocks.order(created_at: :desc)
    end
    
    def create
        @stock = current_user.stocks.build(stock_params)
        if @stock.save
            flash[:success] = "登録できました"
            redirect_to root_url
        else
        end
    end
    
    private
    def stock_params
        params.require(:stock).permit(:category, :foods_name, :number, :limit)
    end
end
