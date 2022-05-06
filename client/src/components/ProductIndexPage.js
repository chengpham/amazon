import React, { Component } from 'react';
import { Product } from '../requests';
import { Link } from 'react-router-dom';

class ProductIndexPage extends Component {
    constructor(props) {
        super(props);
        this.state = { products: [] }
    }
    componentDidMount() {
        Product.index()
          .then((products) => {
            this.setState((state) => {
              return {
                products: products
              }
            })
          })
      }
    createProduct(params) {
        this.setState({
            products: [{id: (Math.max(...this.state.products.map(p => p.id)) + 1), ...params},...this.state.products]
        })
    }
    deleteProduct(id) { this.setState({ products: this.state.products.filter(p => p.id !== id) }) }
    render() {
        return(
            <main>
            {this.state.products.length>0 ? this.state.products.map(p => {
                return(
                <div key={p.id}>
                    <Link to={`/products/${p.id}`}>
                    <h1>{p.id} - {p.title}</h1>
                    </Link>
                    <button onClick={() => this.deleteProduct(p.id)}>Delete</button>
                </div>
                )
            }) : "Products are loading..."}
            </main>
        )
    }
}

export default ProductIndexPage