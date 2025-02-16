public_role = Role.find_or_create_by(name: 'public')
admin_role = Role.find_or_create_by(name: 'admin')

User.find_or_create_by(email: 'admin@example.com') do |user|
  user.password = 'password'
  user.password_confirmation = 'password'
  user.role = admin_role
end

User.find_or_create_by(email: 'public@example.com') do |user|
  user.password = 'password'
  user.password_confirmation = 'password'
  user.role = public_role
end