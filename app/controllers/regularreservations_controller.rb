class RegularreservationsController < ApplicationController
    def create
        @regularreservations = current_user.regularreservations.create(regularreservation_params)
        # redirect_to @reservation.myfunspot
        redirect_to :back, notice:"予約が完了しました"
    end

    private
        def regularreservation_params
            params.require(:regularreservation).permit(:start , :end , :dow, :myfunspot_id)
        end
    
end