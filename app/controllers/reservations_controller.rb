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

        # head = Date.new()
        # tail = Date.new(@end)

        p "****今日は何曜日？*****"
        p  %w(日 月 火 水 木 金 土)[Date.today.wday] + '曜日'
        p "****今日は何曜日？*****"

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