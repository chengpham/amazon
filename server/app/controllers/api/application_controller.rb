class Api::ApplicationController < ApplicationController
    skip_before_action :verify_authenticity_token

    def current_user
        @current_user ||= User.find_by_id session[:user_id]
    end
    helper_method(:current_user)
    def user_signed_in?
        current_user.present?
    end
    helper_method :user_signed_in?
    def authenticate_user!
        render(json: {status: 404}, status: 404) unless user_signed_in?
    end
end
