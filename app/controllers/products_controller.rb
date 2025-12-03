class ProductsController < ApplicationController
  before_action :set_product, only: %i[ show edit update destroy ]
  skip_before_action :verify_authenticity_token

  # GET /products or /products.json
  def index
    @products = Product.all
    respond_to do |format|
      format.json { render json: { products: @products } }
    end
  end

  # GET /products/1 or /products/1.json
  def show
    respond_to do |format|
      format.json { render json: { product: @product } }
    end
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
    @product.update(product_params)
    unless @product.save
      render json: @product.errors.full_messages, status: :unprocessable_entity
    end
    respond_to do |format|
      format.json { render json: { product: @product }, status: :ok }
    end
  end

  # POST /products or /products.json
  def create
    @product = Product.new(product_params)

    respond_to do |format|
      unless @product.save
        format.json { render json: @product.errors.full_messages, status: :unprocessable_entity }
      else
        format.json { render json: { product: @product }, status: :created, location: @product }
      end
    end
  end

  # PATCH/PUT /products/1 or /products/1.json
  def update
    respond_to do |format|
      unless @product.update(product_params)
        format.json { render json: @product.errors.full_messages, status: :unprocessable_entity }
      else
        format.json { render json: { product: @product }, status: :ok, location: @product }
      end
    end
  end

  # DELETE /products/1 or /products/1.json
  def destroy
    @product.destroy!

    respond_to do |format|
      format.html { redirect_to products_path, notice: "Product was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params.expect(:id))
      rescue ActiveRecord::RecordNotFound => e
        render json: { error: e.message }, status: :not_found
    end

    # Only allow a list of trusted parameters through.
    def product_params
      params.expect(product: [ :name, :price ])
    end
end
