require 'rails_helper'

describe 'Discount Index Page' do
  before :each do
    @m1 = Merchant.create!(name: 'Sallies')

    @d1 = Discount.create!(name:"small discount", percentage_discount: 10, quantity: 10, merchant_id: @m1.id)
    @d2 = Discount.create!(name:"medium discount", percentage_discount: 15, quantity: 14, merchant_id: @m1.id)
    @d3 = Discount.create!(name:"big discount", percentage_discount: 20, quantity: 20, merchant_id: @m1.id)
  end

  it "shows all of my bulk discounts including their percentage discount and quantity thresholds" do
    visit "/merchant/#{@m1.id}/dashboard"
    expect(page).to have_link("Bulk Discounts")
    click_link "Bulk Discounts"
    expect(current_path).to eq("/merchant/#{@m1.id}/discounts")
    expect(page).to have_link(@d1.name)
    expect(page).to have_content(@d1.percentage_discount)
    expect(page).to have_content(@d1.quantity)

    expect(page).to have_link(@d2.name)
    expect(page).to have_content(@d2.percentage_discount)
    expect(page).to have_content(@d2.quantity)


    expect(page).to have_link(@d3.name)
    expect(page).to have_content(@d3.percentage_discount)
    expect(page).to have_content(@d3.quantity)
    click_link "#{@d3.name}"
    expect(current_path).to eq("/discounts/#{@d3.id}")
  end
end
