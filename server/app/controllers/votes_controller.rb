class VotesController < ApplicationController
    before_action :authenticate_user!
    def create
        review = Review.find params[:review_id]
        vote = Vote.new user: current_user, review: review
        if !can?(:vote, review)
            flash[:alert] = "You can't vote your own review"
        elsif vote.save
            flash[:success] = "Review voted!"
            redirect_to vote.review.product
        else
            flash[:warning] = vote.errors.full_messages.join(', ')
        end
    end
    def destroy
        vote = Vote.find params[:id]
        if can? :destroy, vote
            vote.destroy
            flash[:success] = "Unvoted Review"
            redirect_to vote.review.product
        else 
            flash[:alert] = "Could not vote review"
            redirect_to vote.review.product
        end
    end
end
