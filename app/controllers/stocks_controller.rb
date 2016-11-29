class StocksController < ApplicationController
    before_action :logged_in_user, only:[:create, :show]
    
    # def show
    #     @user = User.find(params[:id])
    #     @stocks = @user.stocks.order(created_at: :desc)
    # end
    
    def create
        @stock = current_user.stocks.build(stock_params)
        if @stock.save
            redirect_to root_url
            return
        else
            redirect_to current_user, alert: '登録できませんでした'
            return
        end
    end
    
    
    private
    def stock_params
        params.require(:stock).permit(:category, :foods_name, :number, :limit)
    end
end
