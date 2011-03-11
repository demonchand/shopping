require 'spec_helper'

describe "orders/edit.html.erb" do
  before(:each) do
    @order = assign(:order, stub_model(Order,
      :name => "MyString",
      :address => "MyString",
      :email => "MyString"
    ))
  end

  it "renders the edit order form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => order_path(@order), :method => "post" do
      assert_select "input#order_name", :name => "order[name]"
      assert_select "input#order_address", :name => "order[address]"
      assert_select "input#order_email", :name => "order[email]"
    end
  end
end
