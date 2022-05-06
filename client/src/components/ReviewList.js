import React from 'react';
import {ReviewDetails} from './ReviewDetails';
import Star from './StarRating'

export function ReviewList ({ reviews, deleteReview }) {

  return (
    <>
      {reviews? reviews.map((r, i) => {
        return <ReviewDetails
          key={i}
          id={r.id}
          body={r.body}
          reviewer={r.reviewer}
          rating={r.rating}
          created_at={r.created_at}
          deleteReview={deleteReview}
        />
      }) :'reviews loading...'}
    </>
  )
}

