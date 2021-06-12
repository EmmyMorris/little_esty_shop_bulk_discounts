class Discount < ApplicationRecord
  validates_presence_of :percentage_discount,
                        :name,
                        :quantity,
                        :merchant_id

  belongs_to :merchant
end
