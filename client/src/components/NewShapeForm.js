import React from 'react';

const NewShapeForm = ({ createShape }) => {

  const handleSubmit = (event) => {
    event.preventDefault();
    const fd = new FormData(event.currentTarget);
    const params = {
      type: fd.get('type'),
      color: fd.get('color')
    }
    createShape(params);
  }

  return(
    <form onSubmit={handleSubmit}>
      <div>
        <label htmlFor='type'>Type</label>
        <br />
        <input name='type' id='type' />
      </div>
      <div>
        <label htmlFor='color'>Color</label>
        <br />
        <textarea name='color' id='color' />
      </div>
      <div>
        <input type='submit' value='Submit' />
      </div>
    </form>
  )
}

export default NewShapeForm