class Api::V1::ProductsController < Api::ApplicationController
    before_action :authenticate_user!, except: [:index, :show]
    before_action :find_product, only:[:show, :destroy, :update]
    before_action :authorize_user!, only:[:edit, :update, :destroy]

    def index 
        products= Product.order created_at: :desc
        render json: products , each_serializer: ProductCollectionSerializer
    end
    def show
        render json: @product
    end
    def destroy
        if @product.destroy
            head :ok
        else
            head :bad_request
        end
    end
    def create
        product=Product.new product_params
        product.user=current_user
        if product.save
            render json:{id: product.id}
        else
            render(
                json: {errors: product.errors},
                status: 422
            )
        end
    end
    def update
        if @product.update product_params
            render json: {id: @product.id}
        else
            render(
                json: {errors: @product.errors},
                status: 422
            )
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
end
