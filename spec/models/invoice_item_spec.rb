require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  describe "validations" do
    it { should validate_presence_of :invoice_id }
    it { should validate_presence_of :item_id }
    it { should validate_presence_of :quantity }
    it { should validate_presence_of :unit_price }
    it { should validate_presence_of :status }
  end
  describe "relationships" do
    it { should belong_to :invoice }
    it { should belong_to :item }
    it { should have_one(:merchant).through(:item) }
    it { should have_many(:discounts).through(:merchant) }
  end

  before :each do
    @merchant1 = Merchant.create!(name: 'Hair Care')
    @item_1 = Item.create!(name: "Shampoo", description: "This washes your hair", unit_price: 10, merchant_id: @merchant1.id, status: 1)
    @item_2 = Item.create!(name: "Conditioner", description: "This washes your hair", unit_price: 10, merchant_id: @merchant1.id, status: 1)
    @customer_1 = Customer.create!(first_name: 'Joey', last_name: 'Smith')
    @invoice_1 = Invoice.create!(customer_id: @customer_1.id, status: 2)
    @ii_1 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_1.id, quantity: 10, unit_price: 10, status: 0, created_at: "2012-03-27 14:54:09")
    @ii_2 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_2.id, quantity: 5, unit_price: 10, status: 0, created_at: "2012-03-27 14:54:09")
    @transaction1 = Transaction.create!(credit_card_number: 203942, result: 1, invoice_id: @invoice_1.id)

    @d1 = Discount.create!(name:"small discount", percentage_discount: 10, quantity: 10, merchant_id: @merchant1.id)
    @d2 = Discount.create!(name:"medium discount", percentage_discount: 15, quantity: 14, merchant_id: @merchant1.id)
  end

  describe "class methods" do
    it "finds the incomplete invoices" do
      expect(InvoiceItem.incomplete_invoices).to eq([@invoice_1])
    end
  end

  describe "instance methods" do
    it "finds the total revenue with no discounts" do
      expect(@ii_1.total_revenue_no_discounts).to eq(100)
    end

    it "finds the best discount to apply" do
      expect(@ii_1.applied_discounts).to eq(@d1)
    end

    it 'finds the total revenue with discounts' do
      expect(@ii_1.total_revenue_with_discount).to eq(10)
    end

    it "finds the amount the discount saved" do
      expect(@ii_1.discount_revenue).to eq(90)
      expect(@ii_2.discount_revenue).to eq(50)
    end
  end
end
