class Product < ActiveRecord::Base
  validates :title, :image_url, :description, :presence => true
  validates :title, :uniqueness => true
  validates :image_url, :format => {
    :with => %r{\.(gif|jpg|png)$}i,
    :message => 'must be a URL for GIF, JPG or PNG image.'
  }
  validates :price, :numericality => {:greater_then_or_equal_to => 0.01}
end
