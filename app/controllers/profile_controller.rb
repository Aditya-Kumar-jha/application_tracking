class ProfileController < ApplicationController
    before_action :authorize_request
    def get_profile
		@user = User.select("id, name, username, email").find_by(id: @current_user.id)
		render json: {
			profile: @user
		}
	end
    def profile_update
        if @current_user
            if @current_user.update(profile_params)
                @user = User.select("id, name, username, email").find_by(id: @current_user.id)
                render json: {
                    status: 200,
                    profile: @user,
                    info: "Profile changed Successfully"
                }

            else
                render json: {
                    status: 500,
                    info: "Updation failed due to Validations"
                }
            end
        else
            render json: { status: 500, info: "Require User login" }
        end
    end

    def update_password
        if @current_user
            if @current_user.update(password_params)
                render json: {
                    status: 200,
                    info: "Password changed Successfully"
                }
            else
                render json: {
                    status: 500,
                    info: "Type wrong password"
                }
            end
        else
            render json: { status: 500, info: "Require User login" }
        end
    end

    private
    def profile_params
        params.permit(:name, :username, :email)
    end
    def password_params
		params.permit(:password, :password_confirmation)
	end
end
