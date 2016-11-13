class FoodsController < ApplicationController
    before_action :logged_in_user, only: [:create]
    
    def create
        @food = current_user.foods.build(food_params)
        if @food.save
            flash[:success] = "食材を登録しました！"
            redirect_to root_url
        else
            render 'top_pages/home.html.erb'
        end
    end
    
    private
    def food_params
        params.require(:food).permit(:content)
    end
end
