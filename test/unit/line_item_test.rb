require 'test_helper'

class LineItemTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  #test "the truth" do
  #  assert true
  #end
  should belong_to :product
  should belong_to :cart
end
