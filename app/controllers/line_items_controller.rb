class LineItemsController < ApplicationController
  include CurrentCart
  before_action :set_cart
  before_action :set_line_item, only: [:show, :edit, :update, :destroy]

  # GET /line_items
  # GET /line_items.json
  def index
    @line_items = LineItem.all
  end

  # GET /line_items/1
  # GET /line_items/1.json
  def show
  end

  # GET /line_items/new
  def new
    @line_item = LineItem.new
  end

  # GET /line_items/1/edit
  def edit

  end

  # POST /line_items
  # POST /line_items.json
  def create
    product = Product.find(params[:product_id])
    @line_item = @cart.add_product(product.id)

    respond_to do |format|
      if @line_item.save
        format.html { redirect_to store_url }
        format.js   { @current_item = @line_item }
        format.json { render action: 'show',
          status: :created, location: @line_item }
      else
        format.html { render action: 'new' }
        format.json { render json: @line_item.errors,
          status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /line_items/1
  # PATCH/PUT /line_items/1.json
  def update
    
     @li = @line_item
     q = @li.quantity
     if params[:todo] == "plus"
       @cart.plus_quantity(@li) 
     elsif params[:todo] == "minus"
       @cart.minus_quantity(@li) if q>1
     end

    respond_to do |format|
       if @line_item.save
   
        format.html { redirect_to store_url }
        format.json { head :no_content }
        format.js   { @current_item = @line_item }
        format.json { render action: 'show',
          status: :created, location: @line_item }
      
      end
     end
  end

  # DELETE /line_items/1
  # DELETE /line_items/1.json
  def destroy
    @line_item.destroy
    respond_to do |format|
      format.html { redirect_to store_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_line_item
      @line_item = LineItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white
    # list through.
  def line_item_params
      params.require(:line_item).permit(:product_id)
  end

  def line_item_update_params
    params.require(:line_item).permit(:quantity, :action)
  end

end
