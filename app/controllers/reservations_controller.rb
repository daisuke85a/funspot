class ReservationsController < ApplicationController
    def create
        # @reservation = current_user.reservations.create(reservation_params)
        # redirect_to @reservation.myfunspot
        @start_date = params["start_date"]
        @start_time = params["start_time"]
        @end_date = params["end_date"]
        @end_time = params["end_time"]
        # redirect_to :back, notice:"予約が完了しました"
    end

    private
        def reservation_params
            params.permit(:start_date , :start_time, :end_date , :end_time, )
        end
    
end