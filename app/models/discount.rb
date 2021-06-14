class Discount < ApplicationRecord
  validates_presence_of :percentage_discount,
                        :name,
                        :quantity,
                        :merchant_id

 validates :percentage_discount,   numericality: true
 validates :quantity,   numericality: true

  belongs_to :merchant
  has_many :items, through: :merchant
  has_many :invoice_items, through: :items
end
