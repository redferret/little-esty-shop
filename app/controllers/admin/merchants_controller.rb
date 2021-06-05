class Admin::MerchantsController < ApplicationController
  before_action :set_merchants, only: %i[ index ]

  def index
  end

  def update
    if params[:enabled].present?
      merchant = Merchant.find(params[:id])
      merchant.enabled = params[:enabled]
      merchant.save
      redirect_to admin_merchants_path
    end
  end

  private

  def set_merchants
    @enabled_merchants = Merchant.enabled_merchants
    @disabled_merchants = Merchant.disabled_merchants
    @top_merchants = Merchant.top_merchants
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
