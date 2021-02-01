class UsersQuery
  attr_reader :users, :params

  def initialize(users, params)
    @users = users
    @params = params
  end

  def self.call(users, params = {})
    new(users, params).call
  end

  def call
    return object_query if params[:id].present?
    index_query
  end
  
  private

  def index_query
    users.all[1..-1]
  end
  
  def object_query
    users.find_by(id: params[:id])
  end

end