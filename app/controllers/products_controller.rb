class ProductsController < ApplicationController

	before_action :set_product, only: [:show, :edit, :update, :destroy,:back,:report,:like]
  before_action :authenticate_user!, except: [:index]

	# GET /products
  # GET /products.json
  def index
    if params["category_id"].nil?
      @products = Product.all.where(:active=>true)
    else
      @products = Product.where(:category_id=>params["category_id"],:active=>true)
    end
  end

  # GET /products/1
  # GET /products/1.json
  def show
  end

  # GET /products/new
  def new
  	@product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)
    respond_to do |format|
      if @product.save
        format.html { redirect_to @product,  notice: "Product created Successfully" }
        format.json { render action: 'show', status: :created, location: @product }
      else
        format.html { render action: 'new' }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: "Product updated Successfully" }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url }
      format.json { head :no_content }
    end
  end

  def my_products
    if params["category_id"].nil?
      @products = Product.where(:user_id=>current_user.id)
    else
      @products = Product.where(:category_id=>params["category_id"],:user_id=>current_user.id)
    end
  end

  def back
    BackProduct.create(:product_id=>@product.id,:user_id=>current_user.id)
    backers_total = @product.backers_total + 1
    @product.update_columns(:backers_total=>backers_total)
    respond_to do |format|
      format.html { redirect_to @product }
    end
  end

  def report
    ReportProduct.create(:product_id=>@product.id,:user_id=>current_user.id)
    respond_to do |format|
      format.html { redirect_to @product }
    end
  end

  def like
    current_user.like!(@product)
    respond_to do |format|
      format.html { redirect_to @product }
    end
  end

  def recommended
    if params["category_id"].nil?
      @products = Product.all.where(:active=>true)
    else
      @products = Product.where(:category_id=>params["category_id"],:active=>true)
    end
  end

  def popular
    if params["category_id"].nil?
      @products = Product.all.where('backers_total >?',0).sort_by(&:backers_total)
    else
      @products = Product.where('category_id =? and backers_total >?',params["category_id"],0).sort_by(&:backers_total)
    end
  end

  def favorite
    liked_product_ids = Like.where(:liker_id=>1).pluck(:id)
    if params["category_id"].nil?
      @products = Product.where(:id=>liked_product_ids)
    else
      @products = Product.where(:id=>liked_product_ids,:category_id=>params["category_id"])
    end
  end

  private

  	# Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    def product_params
      params.require(:product).permit(:title, :project, :funding_goal, :description, :category_id, :facebook_url, :website,:risks,:user_id,:location,:future_plans,:short_description,:raised_amount,:backers_total,:tag_list,:image,:video)
    end
end

