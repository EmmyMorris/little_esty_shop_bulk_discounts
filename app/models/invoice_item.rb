class InvoiceItem < ApplicationRecord
  validates_presence_of :invoice_id,
                        :item_id,
                        :quantity,
                        :unit_price,
                        :status

  belongs_to :invoice
  belongs_to :item
  has_one :merchant, through: :item
  has_many :discounts, through: :merchant

  enum status: [:pending, :packaged, :shipped]

  def self.incomplete_invoices
    invoice_ids = InvoiceItem.where("status = 0 OR status = 1").pluck(:invoice_id)
    Invoice.order(created_at: :asc).find(invoice_ids)
  end

  def total_revenue_no_discounts
     (quantity * unit_price)
  end

  def applied_discounts
    discounts.where('discounts.quantity <= ?', self.quantity)
    .order(percentage_discount: :desc)
    .first
  end

  def total_revenue_with_discount
    ((applied_discounts.percentage_discount.to_f)/100 * total_revenue_no_discounts)
  end

  def discount_revenue
    if applied_discounts.nil?
      total_revenue_no_discounts
    else
      total_revenue_no_discounts - total_revenue_with_discount
    end
  end
end
