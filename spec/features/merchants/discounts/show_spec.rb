require 'rails_helper'

describe 'Discount Show Page' do
  before :each do
    @m1 = Merchant.create!(name: 'Sallies')

    @d1 = Discount.create!(name:"small discount", percentage_discount: 10, quantity: 10, merchant_id: @m1.id)
    @d2 = Discount.create!(name:"medium discount", percentage_discount: 15, quantity: 14, merchant_id: @m1.id)
    @d3 = Discount.create!(name:"big discount", percentage_discount: 20, quantity: 20, merchant_id: @m1.id)
  end

  it "Shows the bulk discount's quantity threshold and percentage discount" do
    # Merchant Bulk Discount Show
    # As a merchant
    # When I visit my bulk discount show page
    # Then I see the bulk discount's quantity threshold and percentage discount
    visit "/discounts/#{@d1.id}"
    expect(page).to have_content(@d1.name)
    expect(page).to have_content(@d1.merchant.name)
    expect(page).to have_content(@d1.percentage_discount)
    expect(page).to have_content(@d1.quantity)
  end
end
