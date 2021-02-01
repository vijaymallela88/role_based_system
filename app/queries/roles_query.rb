class RolesQuery
  attr_reader :roles, :params

  def initialize(roles, params)
    @roles = roles
    @params = params
  end

  def self.call(roles, params = {})
    new(roles, params).call
  end

  def call
    return object_query if params[:id].present?
    index_query
  end
  
  private

  def index_query
    roles.all[1..-1]
  end
  
  def object_query
    roles.find_by(id: params[:id])
  end

end