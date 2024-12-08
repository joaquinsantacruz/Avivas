class Sale < ApplicationRecord
  belongs_to :employee, class_name: "User"
  has_many :product_sales, dependent: :destroy

  accepts_nested_attributes_for :product_sales, allow_destroy: true, reject_if: :all_blank

  validates :realization_date, presence: true
  validates :total_amount, numericality: { greater_than_or_equal_to: 0 }
  validates :customer_dni, presence: true
  validates :customer_name, presence: true
  validates :employee, presence: true

  validate :at_least_one_product_sold

  private

  def at_least_one_product_sold
    errors.add(:base, "Debe tener al menos un producto") if product_sales.empty?
  end
end
