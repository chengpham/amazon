class ReviewsController < ApplicationController
    before_action :authenticate_user!
    # before_action :find_product
    def create
        @product = Product.find params[:product_id]
        @review = Review.new review_params
        @review.product = @product
        @review.user = @current_user
        
        if @review.save
          redirect_to product_path(@product), notice: 'Review created!'
        else
          render 'products/show'
        end
    end
    def update
        @review=Review.find params[:id]
        if can?(:crud, @review)
            if @review.hide
                @review.hide = false
            else
                @review.hide = true
            end
            @review.save
            redirect_to product_path(@review.product), notice: "Review visibility changed"
        else
            redirect_to root_path, alert: 'Not Authorized'
        end
    end
    def destroy
        @review=Review.find params[:id]
        if can?(:crud, @review)
            @review.destroy
            redirect_to product_path(@review.product), notice: "Review deleted"
        else
            redirect_to root_path, alert: 'Not Authorized'
        end
    end
    private
    # def find_product
    #     @product=Product.find params[:product_id]
    # end
    def review_params
        params.require(:review).permit(:body, :rating)
    end
end
