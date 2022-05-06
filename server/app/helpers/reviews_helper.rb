
module ReviewsHelper
  def display_stars(review)
    # "#{('★' * full_stars)}#{'☆' * empty_stars}"
    "#{('⭐' * review.rating)}#{'☆' * (5-review.rating)}"
  end
end
