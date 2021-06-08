class Admin::MerchantsController < ApplicationController
  before_action :set_merchants, only: %i[ index ]

  def index
  end

  def update
    @merchant = Merchant.find(params[:id])

    if params[:enabled].present?
      merchant = Merchant.find(params[:id])
      merchant.enabled = params[:enabled]
      merchant.save
      redirect_to admin_merchants_path
    elsif @merchant.update(merchant_params)
        flash[:success] = "Merchant Successfully Updated"
        redirect_to admin_merchant_path(@merchant)
    end
  end

  def show
    @merchant = Merchant.find(params[:id])
  end

  def edit
    @merchant = Merchant.find(params[:id])
  end

  def new
    @merchant = Merchant.new
  end

  def create
    merchant = Merchant.new(merchant_params)
    if merchant.save
      merchant.update(enabled: false)
      flash[:notice] = 'New merchant has been created!'
      redirect_to admin_merchants_path
    end
  end

  private

  def set_merchants
    @enabled_merchants = Merchant.enabled_merchants
    @disabled_merchants = Merchant.disabled_merchants
    @top_merchants = Merchant.top_merchants
  end

  def merchant_params
     params.require(:merchant).permit(:name)
  end
end
