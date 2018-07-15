class PagesController < ApplicationController
  def index
    @users = User.all
  end

  def search
    if params[:search].present?

      if params["lat"].present? & params["lng"].present?
        @latitude = params["lat"]
        @longitude = params["lng"]
        geolocation = [@latitude,@longitude]
      else
        results = Geocoder.search(params[:search])
        geolocation = results.first.coordinates
        @latitude = geolocation[0]
        @longitude = geolocation[1]
      end

      @funspots = Myfunspot.near(geolocation, 100, order: 'distance')

      #検索結果が空欄の場合  
    else
      @funspots = Myfunspots.all
      @latitude = @funspots.to_a[0].latitude
      @longitude = @funspots.to_a[0].longitude
    end

  end
  
end
