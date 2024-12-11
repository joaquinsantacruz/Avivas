class ProductSale < ApplicationRecord
  belongs_to :product
  belongs_to :sale

  validates :amount_sold, numericality: { greater_than_or_equal_to: 0 }
  validates :sale_price, numericality: { greater_than_or_equal_to: 0 }
end
