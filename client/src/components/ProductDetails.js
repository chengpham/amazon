import React from 'react';

export function ProductDetails(props) {
  const {title, description, seller, price, created_at} = props
  return (
    <div>
      <h2>{title}</h2>
      <p>{description}</p>
      <p>By {seller? seller.full_name : ''}</p>
      <p>Price: ${price}</p>
    </div>
  ) 
}
