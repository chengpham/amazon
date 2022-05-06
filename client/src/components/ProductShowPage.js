import React, { Component } from 'react'
import {ProductDetails} from './ProductDetails';
import {ReviewList} from './ReviewList';
import { Product } from '../requests';

class ProductShowPage extends Component {
  constructor(props) {
    super(props)
    this.state = { product: {} }
  }
  componentDidMount() {
    Product.show(this.props.match.params.id)
      .then(product => {
        console.log(product)
        this.setState((state) => {
          return {
            product: product
          }
        })
      })
  }
  deleteReview(id) {
    this.setState((state) => {
      return {
        reviews: state.reviews.filter(r => r.id !== id)
      }
    })
  }

  render() {
    
    return(
    <main>
      {Object.keys(this.state.product).length === 0 ? 'Product loading...' :
      <>
      <ProductDetails
        title={this.state.product.title}
        description={this.state.product.description}
        price={this.state.product.price}
        seller={ this.state.product.seller } 
        created_at={this.state.product.created_at}
      />
      <ReviewList
        reviews={this.state.product.reviews}
        deleteReview={this.deleteReview.bind(this)}
      />
      </>
    }
    </main>
    )
  }
}

export default ProductShowPage

