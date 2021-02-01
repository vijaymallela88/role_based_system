class RolesController < ApplicationController
  
  before_action :set_role, only: [:show, :edit, :update, :destroy]

  
  def index
    # @roles = Role.all[1..-1]
    @roles = RolesQuery.call(Role.all, params)
  end

  def show
  end

  def new
    @role = Role.new
  end

  def edit
  end

  def create
  @user = User.find_by_id(current_user.id)
    
    @role = @user.roles.new(role_params)

    respond_to do |format|
      if @role.save
        format.html { redirect_to roles_path, notice: 'Role was successfully created.' }
        format.json { render :show, status: :created, location: @role }
      else
        format.html { render :new }
        format.json { render json: @role.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @role.update(role_params)
        format.html { redirect_to roles_path, notice: 'Role was successfully updated.' }
        format.json { render :show, status: :ok, location: @role }
      else
        format.html { render :edit }
        format.json { render json: @role.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @role.destroy
    respond_to do |format|
      format.html { redirect_to roles_url, notice: 'Role was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_role
      # @role = Role.find(params[:id])
      @role = RolesQuery.call(Role.all, params)
    end

    def role_params
      params.require(:role).permit(:name, :user_id)
    end
end

