class Product < ActiveRecord::Base
  default_scope :order => "title"

  has_many :line_items

  before_destroy :ensure_not_referenced_by_any_line_item

  validates :title, :image_url, :description, :presence => true
  validates :title, :uniqueness => true
  validates :image_url, :format => {
    :with => %r{\.(gif|jpg|png)$}i,
    :message => 'must be a URL for GIF, JPG or PNG image.'
  }
  validates :price, :numericality => {:greater_then_or_equal_to => 0.01}

  def ensure_not_by_any_line_item
    if line_items.count.zero?
      return true
    else
      errors[:base] << "Line Item present"
      return false
    end
  end
end
