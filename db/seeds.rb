# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

roles = [ 'admin', 'manager', 'employee' ]
roles.each do |role_name|
  Role.find_or_create_by(name: role_name)
  if Role.find_by(name: role_name).persisted?
    puts "Rol '#{role_name}' creado o encontrado correctamente."
  else
    puts "Error al crear el rol '#{role_name}'."
  end
end

users = [
  {
    username: "admin1",
    email: "admin1@mail.com",
    phone: "221 2364600",
    password: "123456",
    role: "admin",
    entry_date: Date.current
  },
  {
    username: "admin2",
    email: "admin2@mail.com",
    phone: "221 2364600",
    password: "123456",
    role: "admin",
    entry_date: Date.current
  },
  {
    username: "manager1",
    email: "manager1@mail.com",
    phone: "221 6262437",
    password: "123456",
    role: "manager",
    entry_date: Date.current
  },
  {
    username: "manager2",
    email: "manager2@mail.com",
    phone: "221 6262437",
    password: "123456",
    role: "manager",
    entry_date: Date.current
  },
  {
    username: "employee1",
    email: "employee1@mail.com",
    phone: "221 3675693",
    password: "123456",
    role: "employee",
    entry_date: Date.current
  },
  {
    username: "employee2",
    email: "employee2@mail.com",
    phone: "221 3675693",
    password: "123456",
    role: "employee",
    entry_date: Date.current
  }
]
users.each do |user_data|
  user = User.find_or_create_by(email: user_data[:email]) do |user|
    user.username = user_data[:username]
    user.phone = user_data[:phone]
    user.password = user_data[:password]
    user.entry_date = user_data[:entry_date]
  end
  user.assign_role(user_data[:role])

  if user.persisted?
    puts "Usuario '#{user.username}' creado o encontrado correctamente."
  else
    puts "Error al crear el usuario '#{user.username}': #{user.errors.full_messages.join(', ')}"
  end
end

categories = [
  "Calzado", "Zapatillas", "Botines", "Ojotas", "Ropa", "Camisetas", "Camperas",
  "Remeras", "Buzos", "Pantalones", "Shorts", "Accesorios", "Medias", "Bolsos",
  "Gorras", "Deportes", "Futbol", "Rugby", "Tenis"
]
categories.each do |category_name|
  Category.find_or_create_by(name: category_name)
  if Category.find_by(name: category_name).persisted?
    puts "Categoría '#{category_name}' creada o encontrada correctamente."
  else
    puts "Error al crear la categoría '#{category_name}'."
  end
end

products = [
  {
    name: "Camiseta Aniversario 50 Años Selección Argentina",
    description: "Camiseta Aniversario 50 Años Selección Argentina",
    unit_price: 149_999,
    available_stock: rand(50..1000),
    size: "S",
    color: "Ambient Sky / Cloud White",
    entry_date: Date.current,
    categories: [ "Camisetas", "Deportes", "Futbol" ]
  },
  {
    name: "Camiseta de Arquero Aniversario 50 Años Selección Argentina",
    description: "Camiseta de Arquero Aniversario 50 Años Selección Argentina",
    unit_price: 149_999,
    available_stock: rand(50..1000),
    size: "M",
    color: "Team Green",
    entry_date: Date.current,
    categories: [ "Camisetas", "Deportes", "Futbol" ]
  },
  {
    name: "CAMPUS 00s W",
    description: "CAMPUS 00s W",
    unit_price: 179_999,
    available_stock: rand(50..1000),
    size: "38",
    color: "Core Black / Cloud White / True Pink",
    entry_date: Date.current,
    categories: [ "Calzado", "Zapatillas" ]
  },
  {
    name: "Tenis de Plataforma Bravada 2.0",
    description: "Tenis de Plataforma Bravada 2.0",
    unit_price: 99_999,
    available_stock: rand(50..1000),
    size: "36",
    color: "Cloud White / Cloud White / Chalk White",
    entry_date: Date.current,
    categories: [ "Calzado", "Zapatillas" ]
  },
  {
    name: "Botines F50 Elite Terreno Firme",
    description: "Botines F50 Elite Terreno Firme",
    unit_price: 399_999,
    available_stock: rand(50..1000),
    size: "42",
    color: "Turbo / Aurora Black / Platinum Metallic",
    entry_date: Date.current,
    categories: [ "Calzado", "Botines", "Deportes", "Futbol" ]
  },
  {
    name: "Ojotas adilette",
    description: "Ojotas adilette",
    unit_price: 51_999,
    available_stock: rand(50..1000),
    size: "43",
    color: "Core Black / White / Core Black",
    entry_date: Date.current,
    categories: [ "Calzado", "Ojotas" ]
  },
  {
    name: "Shell Jacket",
    description: "Shell Jacket",
    unit_price: 153_999,
    available_stock: rand(50..1000),
    size: "XL",
    color: "Warm Sandstone / Ivory",
    entry_date: Date.current,
    categories: [ "Ropa", "Camperas" ]
  },
  {
    name: "Remera adidas Women's Basketball Estampada",
    description: "Remera adidas Women's Basketball Estampada",
    unit_price: 42_999,
    available_stock: rand(50..1000),
    size: "M",
    color: "Collegiate Orange",
    entry_date: Date.current,
    categories: [ "Ropa", "Remeras", "Deportes", "Basquet" ]
  },
  {
    name: "Remera Tech llustrate Estampada",
    description: "Remera Tech llustrate Estampada",
    unit_price: 39_999,
    available_stock: rand(50..1000),
    size: "S",
    color: "White",
    entry_date: Date.current,
    categories: [ "Ropa", "Remeras" ]
  },
  {
    name: "Camiseta Los Pumas Home Fan",
    description: "Camiseta Los Pumas Home Fan",
    unit_price: 104_500,
    available_stock: rand(50..1000),
    size: "XXL",
    color: "Ambient Sky / Cloud White",
    entry_date: Date.current,
    categories: [ "Camisetas", "Deportes", "Rugby" ]
  },
  {
    name: "Muñequera de Zapatillas Pequeña",
    description: "Muñequera de Zapatillas Pequeña",
    unit_price: 18_999,
    available_stock: rand(50..1000),
    size: "-",
    color: "White / Black",
    entry_date: Date.current,
    categories: [ "Accesorios", "Tenis" ]
  },
  {
    name: "Buzo con Capucha ADN Aniversario 50 Años Selección Argentina",
    description: "Buzo con Capucha ADN Aniversario 50 Años Selección Argentina",
    unit_price: 124_999,
    available_stock: rand(50..1000),
    size: "M",
    color: "Ambient Sky / Cloud White",
    entry_date: Date.current,
    categories: [ "Ropa", "Buzos", "Deportes", "Futbol" ]
  },
  {
    name: "Pantalón Z.N.E.",
    description: "Pantalón Z.N.E.",
    unit_price: 104_500,
    available_stock: rand(50..1000),
    size: "40",
    color: "Black / White",
    entry_date: Date.current,
    categories: [ "Ropa", "Pantalones" ]
  },
  {
    name: "CLUB 3STR SHORT",
    description: "CLUB 3STR SHORT",
    unit_price: 65_999,
    available_stock: rand(50..1000),
    size: "M",
    color: "Black",
    entry_date: Date.current,
    categories: [ "Ropa", "Shorts" ]
  },
  {
    name: "Medias Trifolio Liner - 3 Pares (UNISEX)",
    description: "Medias Trifolio Liner - 3 Pares (UNISEX)",
    unit_price: 12_999,
    available_stock: rand(50..1000),
    size: "S",
    color: "White / White / Black",
    entry_date: Date.current,
    categories: [ "Accesorios", "Medias" ]
  },
  {
    name: "Mochila Adicolor",
    description: "Mochila Adicolor",
    unit_price: 51_999,
    available_stock: rand(50..1000),
    size: "40",
    color: "Wonder White",
    entry_date: Date.current,
    categories: [ "Accesorios", "Bolsos" ]
  },
  {
    name: "BASEBALL CAP AC",
    description: "BASEBALL CAP AC",
    unit_price: 27_999,
    available_stock: rand(50..1000),
    size: "-",
    color: "Black",
    entry_date: Date.current,
    categories: [ "Accesorios", "Gorras" ]
  }
]

products.each do |product_data|
  product = Product.find_or_create_by(
    name: product_data[:name]
  ) do |product|
    product.description = product_data[:description]
    product.unit_price = product_data[:unit_price]
    product.available_stock = product_data[:available_stock]
    product.size = product_data[:size]
    product.color = product_data[:color]
    product.entry_date = product_data[:entry_date]
    product.categories = product_data[:categories].map do |category_name|
      Category.find_by(name: category_name)
    end.compact
  end

  if product.persisted?
    puts "Producto '#{product.name}' creado o encontrado correctamente."
  else
    puts "Error al crear el producto: #{product.errors.full_messages.join(', ')}"
  end

  images_path = Rails.root.join("db", "images", product_data[:name])
  if Dir.exist?(images_path)
    Dir.foreach(images_path) do |filename|
      next if filename == '.' || filename == '..'
      file_path = File.join(images_path, filename)
      begin
        product.images.attach(
          io: File.open(file_path),
          filename: filename
        )
        puts "Imagen '#{filename}' adjuntada a '#{product.name}'."
      rescue => e
        puts "Error al adjuntar la imagen '#{filename}' para '#{product.name}': #{e.message}"
      end
    end
  else
    puts "Directorio de imágenes no encontrado para '#{product_data[:name]}'."
  end
end

10.times do
  employee_id = rand(3..6)
  realization_date = Date.current
  customer_dni = "23444555"
  customer_name = "Cliente"

  sale = Sale.create(
    realization_date: realization_date,
    total_amount: 0,
    employee_id: employee_id,
    customer_dni: customer_dni,
    customer_name: customer_name
  )

  if sale.persisted?
    puts "Venta ID #{sale.id} creada correctamente."

    products_count = rand(2..5)
    total_amount = 0
    products_added = {}

    products_count.times do
      product = Product.find(rand(1..17))

      amount_sold = rand(5..30)
      if product.available_stock >= amount_sold
        sale_price = product.unit_price

        if products_added[product.id]
          sale_product = products_added[product.id]
          sale_product.update(amount_sold: sale_product.amount_sold + amount_sold)
        else
          sale_product = ProductSale.create(
            product_id: product.id,
            sale_id: sale.id,
            amount_sold: amount_sold,
            sale_price: sale_price
          )
          products_added[product.id] = sale_product
        end

        product.update(available_stock: product.available_stock - amount_sold)

        total_amount += amount_sold * sale_price

        puts "Producto ID #{product.id} agregado o actualizado en la venta ID #{sale.id}."
      else
        puts "Stock insuficiente para el producto ID #{product.id}, omitiendo."
      end
    end

    sale.update(total_amount: total_amount)
    puts "Venta ID #{sale.id} actualizada con el monto total: $#{total_amount}."
  else
    puts "Error al crear la venta: #{sale.errors.full_messages.join(', ')}"
  end
end
