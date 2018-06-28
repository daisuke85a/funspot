class MyfunspotsController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  def show
  end

  def new
    @myfunspot = current_user.myfunspots.build
  end

  def create
    @myfunspot = current_user.myfunspots.build(myfunspot_params)
    if @myfunspot.save
      redirect_to edit_myfunspot_path(@myfunspot), notice: "funspotを作成しました"
    else
      redirect_to new_myfunspot_path(@myfunspot), notice: "funspotを作成できませんでした"
    end
  end

  def edit
    @myfunspot = Myfunspot.find(params[:id])
  end

  def update
  end

  private
  def myfunspot_params
    params.require(:myfunspot).permit(:name,:content,:address,:phone_number,:email,:website,:active)  
  end

end
