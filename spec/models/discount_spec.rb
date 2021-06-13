require 'rails_helper'

RSpec.describe Discount, type: :model do
  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :percentage_discount }
    it { should validate_presence_of :quantity }
    it { should validate_presence_of :merchant_id }
  end
  describe "relationships" do
    it { should belong_to :merchant }
  end
end
