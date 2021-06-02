class ItemsController < ApplicationController
  before_action :set_item, only: %i[show edit update]

  def index
    @items = Merchant.find(params[:merchant_id]).items
  end

  def show
  end

  def new
    @item = Item.new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create
    merchant = Merchant.find(params[:merchant_id])
    
    if merchant.items.create(item_params)
      redirect_to merchant_items_path(merchant)
    end
  end

  def edit
  end

  def update
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:name, :unit_price, :description)
  end
end
