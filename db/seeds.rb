public_role = Role.find_or_create_by(name: 'public')
admin_role = Role.find_or_create_by(name: 'admin')

user1 = User.find_or_create_by(email: 'admin@example.com') do |user|
  user.password = '000000000'
  user.password_confirmation = '000000000'
end
user1.add_role(:admin)

user2 = User.find_or_create_by(email: 'public@example.com') do |user|
  user.password = '000000000'
  user.password_confirmation = '000000000'
end
user2.add_role(:public)

Product.find_or_create_by(name: 'Producto 1') do |product|
  product.description = 'Descripción del Producto 1'
  product.price = 10.0
end

Product.find_or_create_by(name: 'Producto 2') do |product|
  product.description = 'Descripción del Producto 2'
  product.price = 20.0
end

Product.find_or_create_by(name: 'Producto 3') do |product|
  product.description = 'Descripción del Producto 3'
  product.price = 30.0
end