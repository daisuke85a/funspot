class PagesController < ApplicationController
  def index
    @users = User.all
  end

  def toResFlgFromDateTime( datetime )
    hour = datetime.hour * 4
    min = (datetime.min  / 15).round

    return hour + min
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
      #@latitude = @funspots.to_a[0].latitude TODO:heroku上でNoMethodError (undefined method `latitude' for nil:NilClass):と表示されるから仮にコメントアウト
      #@longitude = @funspots.to_a[0].longitude TODO::同上
    end

    #funspotデータを配列にしてまとめる
    @arrfunspots = @funspots.to_a

    if( !params[:start_date].blank? && !params[:end_date].blank? )
      p "******"
      p "if( !params[:start_date].blank? && !params[:end_date].blank? )"
      p "******"

      #この範囲の中で1h空いている時間があるかを検索できる。
      start_date = DateTime.parse(params[:start_date] + " " + params[:start_time] )
      end_date = DateTime.parse(params[:end_date] + " " + params[:end_time])

      reservedFlg = Array.new( 24 * (60 / 4)) #15分毎に予約できる前提とする

      @funspots.each do |funspot|
        p "******"
        p "@funspots.each do |funspot|"
        p "******"
  
        #指定範囲とかぶっている予約をすべて取得する
        coverReserves = funspot.reservations.where(
          "(? < start AND start < ?)
           OR (? < end AND end < ?)
           OR (start <= ? AND ? <= end)",
           start_date, end_date,
           start_date, end_date,
           start_date, end_date,
        )

        p "******coverReserves"
        p coverReserves
        p "******coverReserves"

        coverReserves.each do | coverReserve |
          #start_dateの時間から、end_dataの時間まで、繰り返す
          p "******start_date"
          p coverReserve.start.to_datetime
          p "******end_date"    
          p coverReserve.end.to_datetime

          temp_date = coverReserve.start.to_datetime

          while (temp_date < coverReserve.end)
            p "******予約済み時間"
            p temp_date
            p temp_date.class

            #予約済み配列にTrueを入れていく
            #時間を予約済み配列形式に変換して添字に使う(h*4 + m/15)
            reservedFlg [toResFlgFromDateTime(temp_date)] = 1

            # 15分後 (1/1440日後)
            temp_date = temp_date + Rational(1, 24 * 60 / 15)

          end

          p "******予約済み時間の配列版"
          p reservedFlg

        end

        temp_date = start_date
        blank = 0
        available = 0

        while (temp_date < end_date)
          p "****1時間の空きがあるかチェック***"
          p temp_date
          if(reservedFlg [toResFlgFromDateTime(temp_date)] == nil)
            blank = blank + 1
          else
            blank = 0
          end

          if blank == 4
            p "if blank == 4"
            available = 1
          end 
          # 15分後 (1/1440日後)
          temp_date = temp_date + Rational(1, 24 * 60 / 15)
        end

        # delete unavalable funspot from @funspots
        if available != 1
          @arrfunspots.delete(funspot)
        end
      end
    end

    #以下は消去予定
    # if( !params[:start_date].blank? && !params[:end_date].blank? )

    #   start_date = DateTime.parse(params[:start_date] + " " + params[:start_time] )
    #   end_date = DateTime.parse(params[:end_date] + " " + params[:end_time])

    #   p "*************"
    #   p start_date
    #   p end_date
    #   p "*************"

    #   @funspots.each do |funspot|

    #     #予約済みでないかをチェックする
    #     unavailable = funspot.reservations.where(
    #       "(? < start AND start < ?)
    #        OR (? < end AND end < ?)
    #        OR (start <= ? AND ? <= end)",
    #        start_date, end_date,
    #        start_date, end_date,
    #        start_date, end_date,
    #     ).limit(1)
        
    #     # delete unavalable funspot from @funspots
    #     if unavailable.length > 0
    #       @arrfunspots.delete(funspot)
    #     end
    #   end
    # end
  end
end
