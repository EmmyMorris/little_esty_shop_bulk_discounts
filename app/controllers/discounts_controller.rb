class DiscountsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @discounts = @merchant.discounts
    @holidays = HolidayService.holidays[0..2]
  end

  def show
    @discount = Discount.find(params[:id])
    @merchant = @discount.merchant
    end
end
