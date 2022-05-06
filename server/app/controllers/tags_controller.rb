class TagsController < ApplicationController
    before_action :find_tags, only:[:show]
    def index
        @tags=Tag.all.order(created_at: :desc)
    end
    def show
        @products = @tags.products.order(created_at: :desc)
    end

    private
    def find_tags
        @tags=Tag.find params[:id] 
    end
end

