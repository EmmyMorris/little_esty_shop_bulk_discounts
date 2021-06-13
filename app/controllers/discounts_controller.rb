class DiscountsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @discounts = @merchant.discounts
    # @holidays = HolidayService.holidays[0..2]
  end

  def show
    @discount = Discount.find(params[:id])
    @merchant = @discount.merchant
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create
    @merchant = Merchant.find(params[:merchant_id])
    discount = @merchant.discounts.new(discount_params)
      if discount.save
      redirect_to "/merchant/#{@merchant.id}/discounts"
    else
      flash[:alert] = "Error: #{error_message(discount.errors)}"
      render :new
    end
  end

  def edit
    @discount = Discount.find(params[:id])
  end

  def update
    @merchant = Merchant.find(params[:merchant_id])
    discount = @merchant.discounts.find(params[:id])
    discount.update(discount_params)
    redirect_to "/discounts/#{discount.id}"
  end

  def destroy
    @merchant = Merchant.find(params[:merchant_id])
    discount = @merchant.discounts.find(params[:id])
    discount.destroy
    redirect_to "/merchant/#{@merchant.id}/discounts"
  end

  private
  def discount_params
    params.permit(:name, :percentage_discount, :quantity)
  end
end
