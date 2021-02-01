class EmployeesController < ApplicationController
	before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :set_access_types, only: [:new, :edit, :create]
  before_action :set_roles, only: [:new, :edit, :create]

  
  def index
    # @users = User.all[1..-1]
    @users = UsersQuery.call(User.all, params)
  end

  def show
  end

  def new
    @user = User.new
  end

  def edit
    user_role = UserRole.find_by(:user_id => params[:id])
    @assigned_roles = Role.find user_role.role_id
    @access_type = JSON.parse(user_role.access_type)
  end

  def create
    user_name = User.find_by(:name => params[:name], :email => params[:email])
    @user_id = UserRole.find_by(:user_id => user_name.id, :role_id => params[:user_type]) if user_name.present?
    if !@user_id.present?
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save
      UserRole.create(:user_id => @user.id, :role_id => params[:user_type], :access_type => params[:access_type].to_s)
        format.html { redirect_to employees_path, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
    else
       flash[:notice] = "New user already existed!"
       redirect_to employees_path
    end
  end

 
  def update
    user_role = UserRole.find_by(:user_id => params[:id])
    respond_to do |format|
      if @user.update(user_params)
        user_role.update(:user_id => params[:id], :role_id => params[:user_type], :access_type => params[:access_type].to_s)
        format.html { redirect_to employees_path, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: employee_path }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to employees_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_user
    # @user = User.find(params[:id])
    @user = UsersQuery.call(User.all, params)
  end

  def set_roles
    @user_types = Role.all[1..-1].pluck(:name, :id)
  end

  def set_access_types
    @access_types = [["create"], ["update"], ["show"], ["delete"]]
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
    

end
