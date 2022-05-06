class ApplicationController < ActionController::Base
    def current_user
        @current_user ||= User.find_by_id session[:user_id]
    end
    helper_method(:current_user)
    def user_signed_in?
        current_user.present?
    end
    helper_method :user_signed_in?
    def authenticate_user!
        redirect_to new_session_path, notice: 'Please sign in' unless user_signed_in?
    end
    
    def all_user_ip
        user_ip = request.remote_ip
        Ipaddress.create(ip: user_ip, user: "Guest User")
    end
    # # private
    # def current_user
    #     if session[:user_id].present?
    #         @current_user || User.find_by(id: session[:user_id])
    #     end

    # end
    # helper_method(:current_user)
    # #'helper-method' makes a controller method available to all views (or templates)
    # def user_signed_in?
    #     current_user.present?
    # end
    # helper_method :user_signed_in?
    # def authenticate_user!
    #     unless user_signed_in?
    #         flash[:danger] = "You must sign in or sign up first!"
    #         redirect_to new_session_path
    #     end
    # end
end

