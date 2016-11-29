class UsersController < ApplicationController
  before_action :set_user, only:[:show, :edit, :update]
  before_action :logged_in_user, only:[:edit, :update]
  before_action :check_user, only:[:edit, :update]
  
  def show
    @food = @user.foods.build if logged_in?
    @stock = @user.stocks.build if logged_in?
    @stocks = @user.stocks.all.order(created_at: :desc)
    # #カテゴリーをDBから取ってきて一覧表示させる
    # @categorys = Stock.pluck(:category).uniq
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
  
  def stock_recipe
    @user = User.find(params[:id])
    @stocks = @user.stocks
    @recipes = Array.new
    @stocks.combination(3) do |a, b, c|
      @recipes += get_recipe(a.foods_name, b.foods_name, c.foods_name)
    end

#   ランダムで7つ選ぶ場合の処理    
    temp = @recipes.sample(7)
    @recipes = temp
  end
  
  def get_recipe(food1, food2, food3)
    
    require 'open-uri'

    foodsearchlist = "#{food1} #{food2} #{food3}"
    url = URI.escape("http://cookpad.com/search/#{foodsearchlist}")

    charset = nil
    html = open(url) do |f|
      charset = f.charset # 文字種別を取得
      f.read # htmlを読み込んで変数htmlに渡す
    end
  
    # htmlをパース(解析)してオブジェクトを作成
    doc = Nokogiri::HTML.parse(html, nil, charset)
  
    array = Array.new
    
    doc.xpath('//*[@class="recipe-preview"]').each do |node|
      
      title = node.css('.recipe-title').inner_text
      recipe_url = "http://cookpad.com" + node.css('a').attribute('href').value
      img_url = node.css('img').attribute('src').value
      material = node.css('.material').inner_text
      
      material.gsub!(/\n/, "")
      
      array << {title: title, recipe_url: recipe_url, img_url: img_url, material: material}
    end
    return array
  end  
  
  def get_category
    @foods = current_user.stocks.where(category: params[:id])
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
