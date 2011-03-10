require 'test_helper'

class CartTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  #test "the truth" do
  #  assert true
  #end
  should have_many :line_items
end
