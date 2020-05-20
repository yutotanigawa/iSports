class ApplicationController < ActionController::Base


    def after_sign_up_path_for(resource)
        user_path(resource)
    end


    def after_sign_in_path_for(resource)
        case resource
            when Admin
                admins_root_path
            when User
                user_path(resource)
            end
    end

    def after_sign_out_path_for(resource_or_scope)
        if resource_or_scope == :admins
            new_admin_session_path
        else
            new_user_session_path
        end
    end


    before_action :configure_permitted_parameters, if: :devise_controller?

    protected
    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :gender_status, :birth_date, :prefecture,:valid_status])
    end



end
