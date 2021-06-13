require 'rails_helper'

describe 'Discount Show Page' do
  before :each do
    @m1 = Merchant.create!(name: 'Sallies')
    @d1 = Discount.create!(name:"small discount", percentage_discount: 10, quantity: 10, merchant_id: @m1.id)
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

  it "Can edit the discount" do
    # Merchant Bulk Discount Edit
    # As a merchant
    # When I visit my bulk discount show page
    # Then I see a link to edit the bulk discount
    # When I click this link
    # Then I am taken to a new page with a form to edit the discount
    # And I see that the discounts current attributes are pre-poluated in the form
    # When I change any/all of the information and click submit
    # Then I am redirected to the bulk discount's show page
    # And I see that the discount's attributes have been updated
    visit "/discounts/#{@d1.id}"
    # save_and_open_page
    expect(page).to have_content("Discount Name: small discount")
    expect(page).to have_content("Discount Percentage: 10%")
    expect(page).to have_content("Item Quantity: 10")
    expect(page).to have_link("Edit Discount")
    click_link "Edit Discount"
    expect(current_path).to eq("/discounts/#{@d1.id}/edit")
    fill_in('name', with: 'Discount 3')
    fill_in('Percentage Discount(ex: 15 = 15%):', with: 15)
    click_button('Save Discount')
    expect(current_path).to eq("/discounts/#{@d1.id}")
    expect(page).to have_content("Discount Name: Discount 3")
    expect(page).to have_content("Discount Percentage: 15%")
    expect(page).to have_content("Item Quantity: 10")
  end
end
