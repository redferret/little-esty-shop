class Admin::MerchantsController < ApplicationController
  def index

  end

  def show
    @merchant = Merchant.find(params[:id])
  end

  def edit
    @merchant = Merchant.find(params[:id])
  end

  def update
    @merchant = Merchant.find(params[:id])
    if @merchant.update(merchant_params)
      redirect_to admin_merchant_path(@merchant)
      flash[:notice] = "Merchant Successfully Updated"

    end
  end

  private

  def merchant_params
     params.require(:merchant).permit(:name)
  end
end
