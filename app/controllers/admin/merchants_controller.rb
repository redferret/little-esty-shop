class Admin::MerchantsController < ApplicationController
  before_action :set_merchants, only: %i[ index ]

  def index
  end

  def update
    if params[:status].present?
      merchant = Merchant.find(params[:id])
      merchant.status = params[:status]
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
end
