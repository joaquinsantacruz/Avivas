document.addEventListener('turbo:load', function() {
    // Handle adding new product fields
    const addFieldsButton = document.querySelector('.add_fields');
    const removeFieldsButtons = document.querySelectorAll('.remove_fields');
  
    // Handle adding new product fields
    if (addFieldsButton) {
      addFieldsButton.addEventListener('click', function(e) {
        e.preventDefault();
        const content = addFieldsButton.getAttribute('data-content');
        const newId = new Date().getTime();  // Unique identifier for the new fields
        const newContent = content.replace(/new_product_sale/g, newId);
        const fieldsContainer = document.querySelector('#product_sales_fields');
        fieldsContainer.insertAdjacentHTML('beforeend', newContent);
      });
    }
  
    // Handle removing product fields
    removeFieldsButtons.forEach(function(button) {
      button.addEventListener('click', function(e) {
        e.preventDefault();
        const fieldContainer = button.closest('.nested-fields');
        fieldContainer.remove();
      });
    });
  });
  