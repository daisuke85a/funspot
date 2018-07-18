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
      @funspots = Myfunspot.all
      @latitude = @funspots.to_a[0].latitude
      @longitude = @funspots.to_a[0].longitude
    end

    #funspotデータを配列にしてまとめる
    @arrfunspots = @funspots.to_a

    if( !params[:start].blank? &&!params[:end].blank? )

      start_date = Date.parse(params[:start])
      end_date = Date.parse(params[:end])

      @funspots.each do |funspot|

        #予約済みでないかをチェックする
        unavailable = funspot.reservations.where(
          "(? <= start AND start <= ?)
           OR (? <= end AND end <= ?)
           OR (start < ? AND ? < end)",
           start_date, end_date,
           start_date, end_date,
           start_date, end_date,
        ).limit(1)
        
        # delete unavalable funspot from @funspots
        if unavailable.length > 0
          @arrfunspots.delete(funspot)
        end
      end
    end
  end
end
