class ProductsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  def index
    # @products = Product.all
    @products = ProductsQuery.call(Product.all, params)
    @roles = Role.all
    # role = Role.find_by(:name => "Admin")
    user_role = UserRole.find_by(:user_id => current_user.id)
    @role = Role.find_by(:id => user_role.role_id) if user_role.present?
    @user_roles = JSON.parse(user_role.access_type) if user_role.present?
  end

  def show
  end

  def new
    @product = Product.new
  end

  def edit
  end

  def create
  @user = User.find_by_id(current_user.id)
    
    @product = @user.products.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_product
    # @product = Product.find(params[:id])
    @product = ProductsQuery.call(Product.all, params)
  end

  def product_params
    params.require(:product).permit(:name, :price, :user_id)
  end
  
end
