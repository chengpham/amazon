class BillController < ApplicationController
    def index
        @amount = params[:amount]
        @tax = params[:tax]
        @tip = params[:tip]
        @num_of_people = params[:num_of_people]
        @split_amount = @amount ? 
        @amount.to_f * (@tax.to_f/100+1) * (@tip.to_f/100+1) / @num_of_people.to_f :
        0
    end
end
