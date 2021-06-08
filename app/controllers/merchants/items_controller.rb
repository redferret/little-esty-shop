class Merchants::ItemsController < ApplicationController
  before_action :set_item_and_merchant, only: %i[ show edit update ]
  before_action :convert_unit_price, only: %i[ create update]

  def index
    @merchant = Merchant.find(params[:merchant_id])
    @items = @merchant.items
  end

  def show
  end

  def new
    @item = Item.new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create
    @merchant = Merchant.find(params[:merchant_id])
    @item = @merchant.items.create(item_params)
    if not(@item.has_errors?)
      flash[:success] = 'New Item Created'
      redirect_to merchant_items_path(@merchant)
    else
      flash[:alert] = "Item not created - #{@item.humanize_errors}"
      redirect_to new_merchant_item_path(@merchant)
    end
  end

  def edit
  end

  def update
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:id])
    if params[:status].present?
      @item.status = params[:status]
      @item.save
      redirect_to merchant_items_path(@merchant)
    elsif @item.update(item_params)
      flash[:success] = 'Item Updated'
      redirect_to merchant_item_path(@merchant, @item)
    else
      flash[:alert] = "Item not updated - #{@item.humanize_errors}"
      redirect_to edit_merchant_item_path(@merchant, @item)
    end
  end

  private

  def convert_unit_price
    given_unit_price = params[:item][:unit_price] if params[:item].present? && params[:item][:unit_price].present?
    if given_unit_price
      params[:item][:unit_price] = Item.convert_unit_price_to_cents(given_unit_price[1..-1].to_f)
    end
  end

  def set_item_and_merchant
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:name, :unit_price, :description, :merchant_id)
  end
end