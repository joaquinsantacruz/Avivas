class Product < ApplicationRecord
  has_many :product_sales
  has_many :sales, through: :product_sales # Utilizo through porque hay logica extra en la tabla intermedia

  has_and_belongs_to_many :categories

  has_many_attached :images

  validates :name, presence: true, length: { maximum: 255 }
  validates :unit_price, numericality: { greater_than_or_equal_to: 0 }
  validates :available_stock, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :images, length: { maximum: 3, message: "Puedes subir un máximo de 3 imágenes" }
  validates :categories, presence: { message: "Debe tener al menos una categoría" }

  validate :max_5_images

  def self.ransackable_attributes(auth_object = nil)
    [ "available_stock", "color", "created_at", "deleted_date", "description", "entry_date", "id", "name", "size", "unit_price", "updated_at" ]
  end

  def self.ransackable_associations(auth_object = nil)
    [ "categories", "images_attachments", "images_blobs", "product_sales", "sales" ]
  end

  private

  def max_5_images
    if images.attached? && images.count > 5
      errors.add(:images, "Puedes subir un máximo de 5 imágenes")
    end
  end
end
