class Merchants::ItemsController < ApplicationController
  before_action :set_item_and_merchant, except: %i[ index new ]

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
    if @merchant.items.create(item_params)
      flash[:success] = 'New Item Created'
      redirect_to merchant_items_path(@merchant)
    else
      flash[:alert] = "Item not created - #{@merchant.items.errors}"
    end
  end

  def edit
  end

  def update
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:id])
    if @item.update(item_params)
      flash[:success] = 'Item Updated'
      redirect_to merchant_items_path(@merchant)
    else
      flash[:alert] = "Item not updated - #{@item.errors}"
      render merchant_item_path(@merchant, @item)
    end
  end

  private

  def set_item_and_merchant
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:name, :unit_price, :description)
  end
end