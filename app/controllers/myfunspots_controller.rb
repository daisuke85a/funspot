class MyfunspotsController < ApplicationController
  before_action :authenticate_user!

  def index
    @funspots = current_user.myfunspots
  end

  def show
    @funspot = Myfunspot.find(params[:id])
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
    @myfunspot = Myfunspot.find(params[:id])
    if @myfunspot.update(myfunspot_params)
      redirect_to :back
    else
      
    end

  end

  private
  def myfunspot_params
    params.require(:myfunspot).permit(:name,:content,:address,:phone_number,:email,:website,:active)  
  end

end
