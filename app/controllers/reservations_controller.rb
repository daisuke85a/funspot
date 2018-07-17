class ReservationsController < ApplicationController
    def create
        # @reservation = current_user.reservations.create(reservation_params)
        # redirect_to @reservation.myfunspot
        # @start_date = params["start_date"]
        # @start_time = params["start_time"]
        # @end_date = params["end_date"]
        # @end_time = params["end_time"]
        @start = params["start_date"] + " " + params["start_time"]
        @end = params["end_date"] + " " + params["end_time"]
        @reservation = Reservation.new(user_id: current_user.id, myfunspot_id: params["myfunspot_id"], start: @start, end: @end)
        @reservation.save()
        redirect_to :back, notice:"予約が完了しました"
    end

    def applyregular

        @funspot = Myfunspot.find(params[:id])
        @start = Date.today #今日から TODO:データベース上はDateTimeにしているが、どうやらDataのほうが便利らしいのでDateに統一したい。
        @end = Date.today >> 3 #3ヶ月後まで

        (@start..@end).each { |date| 
            # すべての定期予約から、該当する曜日に相当する定期予約を取得する（Where文でとってきたい)曜日に値する
            p %w(日 月 火 水 木 金 土)[date.wday] + '曜日'
            @regulars = Regularreservation.where(myfunspot_id: params[:id], dow: date.wday)
            p @regulars

            # TODO: 曜日に該当する定期予約が見つかったら、開始時間と終了時間を取得して予約する。
            # (@regulars).each { |regular 
            
            # }



            #  @regular = Myfunspot.find(params[:id])
            # for @myfunspot.regularreservations.each do |regular|
            # regular
            # end
        }

        # for (@start..@end).each do |date| 
        #     p %w(日 月 火 水 木 金 土)[date.wday] + '曜日'
        # end

        # p "****今日は何曜日？*****"
        # p  %w(日 月 火 水 木 金 土)[Date.today.wday] + '曜日'
        # p "****今日は何曜日？*****"



        redirect_to :back, notice:"定期予約を反映しました"

        # #開始日から終了日
        # for 
                        
        #     # 1日ずつループ
        #     for (@start..@end).each do |date| 
        #         date.
        #     end    
        #         { |date| p date.strftime('%Y%m%d') }
        #     # => '20160101', '20160102', '20160103', ...

        #     #該当する曜日を取得する
            
        #     #該当する曜日の定期予約を抽出して、すべて予約する（TODO::whereとか使う？SQL文チックなのを書く必要ありそう）
        #     for @myfunspot.regularreservations.each do |regular|
        #         regular
        #     end
        # end

    end

    private
        def reservation_params
            # params.permit(:start_date , :start_time, :end_date , :end_time, )
        end
    
end