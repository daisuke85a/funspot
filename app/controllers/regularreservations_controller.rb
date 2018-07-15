class RegularreservationsController < ApplicationController
    def create
        @reservation = current_user.regularreservations.create(regularreservation_params)
        # redirect_to @reservation.myfunspot
        redirect_to :back, notice:"予約が完了しました"
    end

    private
        def regularreservation_params
            params.require(:regularreservation_params).permit(:start , :end)
        end
    
end