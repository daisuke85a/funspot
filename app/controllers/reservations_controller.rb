class ReservationsController < ApplicationController
    def create
        @reservation = current_user.reservations.create(reservation_params)
        # redirect_to @reservation.myfunspot
        redirect_to :back, notice:"予約が完了しました"
    end

    private
        def reservation_params
            params.require(:reservation).permit(:start , :end)
        end
    
end