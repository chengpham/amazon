
const BASE_URL = 'http://localhost:3000/api/v1';
const Session = {
  create(params) {
    return fetch(`${BASE_URL}/session`, {
      headers: {'Content-Type': 'application/json'},
      credentials: 'include', 
      method: 'POST',
      body: JSON.stringify(params)
    }).then((res) => {
      return res.json();
    })
  }
}
const Products = {
  index() {
    return fetch(`${BASE_URL}/products`)
      .then(res => {
        console.log(res)
        return res.json();
      })
  },
  create(params) {
    return fetch(`${BASE_URL}/products`, {
      method: 'POST',
      credentials: 'include',
      headers: {'Content-Type': 'application/json'},
      body: JSON.stringify(params)
    }).then(res => res.json())
  },
  show(id) {
    return fetch(`${BASE_URL}/products/${id}`)
      .then(res => res.json())
  }
}
Session.create({  email: 'js@winterfell.gov', password: 'supersecret' }).then(console.log)
function renderProducts(products) {
  document.querySelector('ul.product-list').innerHTML = products.map(p =>  `<li> <a class="product-link" href="#" data-id="${p.id}"> <span>${p.id} - </span> ${p.title} - $${p.price}</a> </li>`).join('');
}
function renderProductShow(p) {
  document.querySelector('#product-show').innerHTML = `<h1>${p.title}</h1><p>${p.description}</p><p>$${p.price}</p>`
  navigateTo('product-show')
}
function navigateTo(id) {
  document.querySelectorAll('.page').forEach(node => node.classList.remove('active') )
  document.querySelector(`.page#${id}`).classList.add('active');
}

document.addEventListener('DOMContentLoaded', () => {
  Products.index().then(products => { renderProducts(products) })
  const newProductForm = document.querySelector('#new-product-form');
  newProductForm.addEventListener('submit', (event) => {
    event.preventDefault();
    const fd = new FormData(event.currentTarget);
    Products.create({ title: fd.get('title'), description: fd.get('description'), price: fd.get('price') })
      .then(data => {
        if (data.id) return Products.index();
        throw data;
      }).then(products => {
        navigateTo('product-index')
        renderProducts(products)
      }).catch(err => {
        newProductForm.querySelectorAll('p').forEach(n => n.remove())
        for (const key in err.errors) {
          document.createElement('p').innerText = err.errors[key].join(',  ');
          newProductForm.querySelector(`#${key}`).parentNode.prepend(document.createElement('p'));
        }
      })
  })

  document.querySelector('.navbar').addEventListener('click', (event) => {
    event.preventDefault();
    navigateTo(event.target.dataset.target)
  })

  document.querySelector('ul.product-list').addEventListener('click', (event) => {
    event.preventDefault();
    if (event.target.closest('a')) {
      Products.show(event.target.closest('a').dataset.id)
        .then(p =>  renderProductShow(p) )
    }
  })
})
