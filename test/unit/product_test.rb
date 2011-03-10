require 'test_helper'

class ProductTest < Test::Unit::TestCase
  should have_many(:line_items)
  should validate_presence_of(:title)
  should validate_presence_of(:description)
  should validate_presence_of(:image_url)
  should validate_uniqueness_of(:title)
  should validate_numericality_of(:price)
  
  # describe Product do
  #   it { should have_many(:line_items) }
  #   it { should validate_presence_of(:title) }
  # end
end
