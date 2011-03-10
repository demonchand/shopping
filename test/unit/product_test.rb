require 'test_helper'

class ProductTest < Test::Unit::TestCase
  should have_many(:line_items)
  should validate_presence_of(:title)

 # describe Product do
 #   it { should have_many(:line_items) }
 #   it { should validate_presence_of(:title) }
 # end
end
#class ProductTest < ActiveSupport::TestCase
  # Replace this with your real tests.
#  test "the truth" do
#    assert true
#  end
#end

