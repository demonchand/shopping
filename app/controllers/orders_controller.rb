class OrdersController < ApplicationController
  
  include ActiveMerchant::Billing
  def checkout
    setup_response = gateway.setup_purchase(1000,
                                            :ip                => request.remote_ip,
#                                            :return_url        => orders_confirm_url, #url_for(:action => 'confirm', :only_path => false),
                                            :return_url        => url_for(:action => 'confirm', :only_path => false),        
                                            :cancel_return_url => root_url#url_for(:action => 'index', :only_path => false)
                                            )
    redirect_to gateway.redirect_url_for(setup_response.token)
  end
  
  def index
    @orders = Order.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @orders }
    end
  end

  # GET /orders/1
  # GET /orders/1.xml
  def show
    @order = Order.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @order }
    end
  end

  # GET /orders/new
  # GET /orders/new.xml
  def new
    if current_cart.line_items.empty?
      redirect_to store_url, :notice => "Your cart is empty now"
      return
    end
    @order = Order.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @order }
    end
  end

  # GET /orders/1/edit
  def edit
    @order = Order.find(params[:id])
  end

  # POST /orders
  # POST /orders.xml
  def create
    @order = Order.new(params[:order])

    respond_to do |format|
      if @order.save
        format.html { redirect_to(@order, :notice => 'Order was successfully created.') }
        format.xml  { render :xml => @order, :status => :created, :location => @order }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @order.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /orders/1
  # PUT /orders/1.xml
  def update
    @order = Order.find(params[:id])

    respond_to do |format|
      if @order.update_attributes(params[:order])
        format.html { redirect_to(@order, :notice => 'Order was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @order.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.xml
  def destroy
    @order = Order.find(params[:id])
    @order.destroy

    respond_to do |format|
      format.html { redirect_to(orders_url) }
      format.xml  { head :ok }
    end
  end

  def confirm
    redirect_to :action => 'index' unless params[:token]
    details_response = gateway.details_for(params[:token])
    if !details_response.success?
      @message = details_response.message
      render :action => 'error'
      return
    end
    @address = details_response.address
   end
  
  def complete
    purchase = gateway.purchase(1000,
                                :ip       => request.remote_ip,
                                :payer_id => params[:payer_id],
                                :token    => params[:token]
                                )
    
    if !purchase.success?
      @message = purchase.message
      render :action => 'error'
      return
    end
  end
  
  private
  def gateway
    @gateway ||= PaypalExpressGateway.new(
                                          :login => "seller_1299232941_biz_api1.gmail.com",
                                          :password => "6LWSRTJWTLD9FMJB",
                                          :signature => "AR9Pt8A5jeHO4g.gC-vXGDEp.Z8VAWS97jMqCze97gVnnyb0GWgksDj."
                                          )
  end

  
end
