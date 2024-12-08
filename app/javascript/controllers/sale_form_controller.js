import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "productList", "addButton" ]

  addProduct(event) {
    event.preventDefault()
    
    // Obtener el timestamp para crear un unique identifier
    const time = new Date().getTime()
    
    // Clonar el primer conjunto de campos de producto
    const templateNode = this.productListTarget.querySelector('.nested-fields')
    const newNode = templateNode.cloneNode(true)
    
    // Modificar los nombres e ids para que sean únicos
    newNode.querySelectorAll('input, select').forEach((el) => {
      const nameAttr = el.getAttribute('name')
      const idAttr = el.getAttribute('id')
      
      if (nameAttr) {
        el.setAttribute('name', nameAttr.replace(/\d+/, time))
      }
      
      if (idAttr) {
        el.setAttribute('id', idAttr.replace(/\d+/, time))
      }
      
      // Limpiar valores
      el.value = ''
    })
    
    // Añadir botón de eliminar
    const removeLink = document.createElement('a')
    removeLink.href = '#'
    removeLink.textContent = 'Eliminar'
    removeLink.classList.add('remove_fields')
    removeLink.addEventListener('click', (e) => {
      e.preventDefault()
      newNode.remove()
    })
    
    newNode.appendChild(removeLink)
    
    // Añadir al DOM
    this.productListTarget.appendChild(newNode)
  }
}