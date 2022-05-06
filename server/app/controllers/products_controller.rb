class ProductsController < ApplicationController
    before_action :authenticate_user!, except: [:index, :show]
    before_action :find_product, only:[:show, :edit, :update, :destroy]
    before_action :authorize_user!, only:[:edit, :update, :destroy]
    def index
        if params[:tag]
            @tag=Tag.find_or_initialize_by(name: params[:tag])
            @products=@tag.products.order(created_at: :desc)
        else
            @products=Product.all.order(created_at: :desc)
        end
        respond_to do |format|
            format.html {render}
            format.json {render json: @products}
        end
    end
    def show
        @reviews=@product.reviews.left_joins(:votes).group("reviews.id").order("COUNT(votes.id) DESC")
        @review=Review.new
        @favourite = @product.favourites.find_by_user_id current_user if user_signed_in?
    end
    def destroy
        @product.destroy
        redirect_to products_path
    end
    def new
        @product=Product.new
    end
    def create
        @product=Product.new product_params
        @product.user = current_user
        if @product.save
            redirect_to product_path(@product.id), notice: "Post created successfully"
        else
            render :new
        end
    end
    def edit
    end
    def update
        if @product.update product_params
            redirect_to product_path(@product.id)
        else
            render :edit
        end
    end
    private
    def find_product
        @product=Product.find params[:id] 
    end
    def product_params
        params.require(:product).permit(:title, :description, :price, :tag_names)
    end
    def authorize_user!
        redirect_to root_path, alert: "Not Authorized" unless can?(:crud, @product)
    end
    # def self.top_voted
    #     select("product.id, count(votes.id) AS votes_count")
    #     .joins(:votes)
    #     .group("product.id")
    #     .order("votes_count DESC")
    #   end
    
end
