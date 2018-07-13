class PagesController < ApplicationController
  def index
    @users = User.all
  end

  def search
    if params[:search].present?
      @latitude = params["lat"]
      @longitude = params["lng"]
      geolocation = [@latitude,@longitude]
      @funspots = Myfunspot.near(geolocation, 1, order: 'distance')

      #検索結果が空欄の場合  
    else
      @funspots = Myfunspots.all
      @latitude = @funspots.to_a[0].latitude
      @longitude = @funspots.to_a[0].longitude
    end

  end
  
end
