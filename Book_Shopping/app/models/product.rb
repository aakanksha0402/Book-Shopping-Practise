class Product < ActiveRecord::Base
has_many :line_items
has_many :carts, through: :line_items
before_destroy :is_existing

validates :title, presence: true,uniqueness: true
validates :description, presence: true
validates :image_url, presence: true
validates :price,numericality: {greater_than_or_equal_to: 0.01}
validates :image_url, :format => { :with => %r{\.(gif|jpg|png)\z}i, :message => "Image must have extension like png, jpg, jpeg or gif"}

  def self.ordered
    Product.order(:updated_at).last
  end

  def is_existing
    if line_items.count > 0
    errors.add(:base,"YOU CANNOT DELETE IT")
    return false
    end
  end
end
