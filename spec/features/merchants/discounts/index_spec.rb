require 'rails_helper'

describe 'Discount Index Page' do
  before :each do
    @m1 = Merchant.create!(name: 'Sallies')

    @d1 = Discount.create!(name:"small discount", percentage_discount: 10, quantity: 10, merchant_id: @m1.id)
    @d2 = Discount.create!(name:"medium discount", percentage_discount: 15, quantity: 14, merchant_id: @m1.id)
    @d3 = Discount.create!(name:"big discount", percentage_discount: 20, quantity: 20, merchant_id: @m1.id)
  end

  it "shows all of my bulk discounts including their percentage discount and quantity thresholds" do
    # Merchant Bulk Discounts Index
    # As a merchant
    # When I visit my merchant dashboard
    # Then I see a link to view all my discounts
    # When I click this link
    # Then I am taken to my bulk discounts index page
    # Where I see all of my bulk discounts including their
    # percentage discount and quantity thresholds
    # And each bulk discount listed includes a link to its show page
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

  it "shows a section with a header of Upcoming Holidays" do
    # As a merchant
    # When I visit the discounts index page
    # I see a section with a header of "Upcoming Holidays"
    # In this section the name and date of the next 3 upcoming US holidays are listed.
    # Use the Next Public Holidays Endpoint in the [Nager.Date API](https://date.nager.at/swagger/index.html)
    visit ("/merchant/#{@m1.id}/discounts")
    expect(page).to have_content("Upcoming US Holidays")
    # expect(page).to have_content("Independence Day")
    # expect(page).to have_content("2021-07-05")
    # expect(page).to have_content("Labour Day")
    # expect(page).to have_content("2021-09-06")
    # expect(page).to have_content("Columbus Day")
    # expect(page).to have_content("2021-10-11")
  end

  it "Creates and shows a new discount" do
    # Merchant Bulk Discount Create
    # As a merchant
    # When I visit my bulk discounts index
    # Then I see a link to create a new discount
    # When I click this link
    # Then I am taken to a new page where I see a form to add a new bulk discount
    # When I fill in the form with valid data
    # Then I am redirected back to the bulk discount index
    # And I see my new bulk discount listed
    visit ("/merchant/#{@m1.id}/discounts")
    expect(page).to have_link("Create New Discount")
    click_link "Create New Discount"
    expect(current_path).to eq("/merchant/#{@m1.id}/discounts/new")
    fill_in('name', with: 'Discount 3')
    fill_in('Percentage Discount(ex: 15 = 15%):', with: 10)
    fill_in('Quantity:', with: 12)
    click_button('Create Discount')
    expect(current_path).to eq("/merchant/#{@m1.id}/discounts")
    expect(page).to have_content("Discount Name: Discount 3")
    expect(page).to have_content("Discount Percentage: 10%")
    expect(page).to have_content("Item Quantity: 12")
  end

  it "Can show a link to delete a discount and delete it" do
    # Merchant Bulk Discount Delete
    # As a merchant
    # When I visit my bulk discounts index
    # Then next to each bulk discount I see a link to delete it
    # When I click this link
    # Then I am redirected back to the bulk discounts index page
    # And I no longer see the discount listed
    visit ("/merchant/#{@m1.id}/discounts")
    expect(page).to have_link("Delete Discount: #{@d1.name}")
    expect(page).to have_content("Discount Name: small discount")
    expect(page).to have_content("Discount Percentage: 10%")
    expect(page).to have_content("Item Quantity: 10")
    click_link "Delete Discount: #{@d1.name}"
    expect(current_path).to eq("/merchant/#{@m1.id}/discounts")
    expect(page).to_not have_link("Delete Discount: #{@d1.name}")
    expect(page).to_not have_content("Discount Name: small discount")
    expect(page).to_not have_content("Discount Percentage: 10%")
    expect(page).to_not have_content("Item Quantity: 10")
  end
end
