import React, { Component } from 'react'
import shapesData from '../shapesData';
import NewShapeForm from './NewShapeForm';

class ShapeMaker extends Component {
    constructor(props) {
      super(props)
      this.state = { shapes: shapesData }
      
    }
    createShape(params) {
        this.setState({
            shapes: [...this.state.shapes, {id: (Math.max(...this.state.shapes.map(p => p.id)) + 1), ...params}]
        })
    }
    render(){
        return(
            <main>
                <hr/>
                <h1>Shape Maker</h1>
                <NewShapeForm createShape={this.createShape.bind(this)}/>
                {this.state.shapes.map(s => {
                return(
                <div key={s.id} className={s.type} style={{ backgroundColor: s.color}} />
                
                )
            })}
            </main>
        )
    }
}

export default ShapeMaker