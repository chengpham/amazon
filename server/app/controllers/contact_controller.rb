class ContactController < ApplicationController
    def index
    end
    def create
        @full_name = params[:full_name]
        @email = params[:email]
        @message = params[:message]
    end
end
