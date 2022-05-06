import React, { Component } from 'react'
import NewProductForm from './NewProductForm';
import { Product } from '../requests';

class ProductNewPage extends Component {
  constructor(props) {
    super(props);
    this.createProduct = this.createProduct.bind(this)
  }

  createProduct(params) {
    Product.create(params)
      .then(({ id }) => {
        this.props.history.push(`/products/${id}`)
      })
  }

  render() {
    return(
      <main>
        <NewProductForm createProduct={this.createProduct} />
      </main>
    )
  }
}

export default ProductNewPage