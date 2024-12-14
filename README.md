# Proyecto TTPS - Ruby

## Requerimientos

- Ruby 3.3.6
- Rails 8.0.0
- Database: SQLite3

## Instalación del proyecto

### Clonar el repo

```bash
$ git clone https://github.com/joaquinsantacruz/Avivas.git
```

### Instalar dependencias

```bash
$ bundle install
```

### Preparar la base de datos

```bash
$ rails db:reset
```

## Base de datos

### Product
- Esta tabla se utilizó para modelar cada producto utilizado en la pagina. Talle y color fueron agregados como campos de tipo string para facilitar el manejo de las entidades. Sin embargo, el atributo categorías si se implementó como un modelo a parte, por gusto propio más que por otra cosa.

### Category
- Esta tabla se utilizó para modelar y persistir las categorías usadas en la página. Debido a la relación muchos a muchos entre Category y Product, debió crearse una tabla intermedia llamada categories_products.

### Sale
- Esta tabla se utilizó para modelar las ventas asentadas en la página. Los campos referidos al cliente fueron implementados como campos de tipo string (customer_dni, customer_name) para no dificultar la creación tanto de ventas como de clientes. Debido a la relación muchos a muchos entre Sale y Product, debió implementarse una tabla intermedia llamada product_sales.

### ProductSale
- Esta tabla se implementó para modelar cada item relacionado a una venta junto a un producto. Se utilizó para persistir la cantidad de productos vendidos, junto al precio en el momento de la realización de la venta. 

### User
- Esta tabla se utilizó para modelar los usuarios autenticados que interactúan con el lado de la administración de la página. Para el manejo de roles se utilizo rolify, para la autenticación devise, y para la autorización se utilizó cancancan

## Gemas utilizadas
| Nombre | Utilidad |
| ------ | -------- |
| rolify | Facilitar la utilización de roles dentro de usuarios autenticados |
| devise | Facilitar la autenticación de usuarios y manejo de sesiones |
| cancancan | Abstraer y facilitar la autorización de usuarios autenticados y no autenticados a ciertas vistas de la página |
| ransack | Facilitar el filtrado y la búsqueda de productos en el home de la página |

## Ejecución de la aplicación

```bash
$ rails server
```

O su version resumida:

```bash
$ rails s
```

## Empezar a usar la aplicación

#### Para facilitar el uso de la página y dar un inicio más amigable se incluyeron varios registros en el seeds.rb, incluidos usuarios para el testeo de funciones que los incluyan:

Administradores:

- Emails: `admin1@mail.com` | `admin2@mail.com`
- Contraseña: `123465`

Gerentes:

- Emails: `manager1@mail.com` | `manager2@mail.com`
- Contraseña: `123465`

Empleados:

- Emails: `employee1@mail.com` | `employee2@mail.com`
- Contraseña: `123465`

### Para entrar al panel de administración se necesita ingresar desde la url "localhost:3000/admin" 

### Ejecucion del seeds.rb:
```bash
$ rails db:seed
```