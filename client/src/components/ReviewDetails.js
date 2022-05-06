import { StarRating } from './StarRating'

export function ReviewDetails({ body, reviewer, rating, deleteReview, id }) {
    return (
      <div>
        <p>{body}</p>
        <p>By {reviewer? reviewer : ''}</p>
        <p>Rating: <StarRating max={5} currentNumber={rating} /></p>
        <p><button onClick={() => deleteReview(id)}>Delete</button></p>
      </div>
    )
  }
  
