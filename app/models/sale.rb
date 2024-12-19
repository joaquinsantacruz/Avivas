class Sale < ApplicationRecord
  belongs_to :employee, class_name: "User"
  has_many :product_sales, dependent: :destroy
  has_many :products, through: :product_sales


  accepts_nested_attributes_for :product_sales, allow_destroy: true, reject_if: :all_blank

  validates :realization_date, presence: true
  validates :total_amount, numericality: { greater_than_or_equal_to: 0 }
  validates :customer_dni, presence: true
  validates :customer_name, presence: true
  validates :employee, presence: true

  def logic_delete
    self.update(deleted_at: Time.current)

    self.product_sales.each do |product_sale|
      Product.find(product_sale.product_id).restock(product_sale.amount_sold)
    end
  end
end
