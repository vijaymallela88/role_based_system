class RegistrationsController < Devise::RegistrationsController
	before_action :authenticate_user!
	

	def create
		@users = User.all
		if !@users.present?
			@user = User.new(sign_up_params)
			if @user.save
			  role = Role.create(:user_id => @user.id, :name => "Admin")
			  user_role = UserRole.create(:user_id => @user.id, :role_id => role.id, :access_type => ["create", "update", "show", "delete"])
	          flash[:notice] = "Admin created successfully!"
	          redirect_to new_user_session_path
            else
	          flash[:notice] = "Please enter valid log-in details!"
	          redirect_to new_user_registration_path
		    end
	    else
	      flash[:notice] = "Admin already created!"
	      redirect_to new_user_session_path
	    end
	end
	

	private
	def sign_up_params 
	  params.require(:user).permit(:name, :email, :password, :password_confirmation)
	end
	def account_update_params
	  params.require(:user).permit(:name, :email, :password, :password_confirmation, :current_password)
	end
end