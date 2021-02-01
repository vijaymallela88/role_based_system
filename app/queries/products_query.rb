class ProductsQuery
  attr_reader :products, :params

  def initialize(products, params)
    @products = products
    @params = params
  end

  def self.call(products, params = {})
    new(products, params).call
  end

  def call
    return object_query if params[:id].present?
    index_query
  end
  
  private

  def index_query
    products.all
  end
  
  def object_query
    products.find_by(id: params[:id])
  end

end