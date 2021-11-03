# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

admin_user = User.find_or_create_by!(email: 'admin@admin.com') do |user|
    user.first_name = 'Admin'
    user.last_name = 'Test'
    user.password = 'admin123'
    user.document_number = '12345678'
    user.birthdate = Date.new(1990, 1, 1)
    user.comorbidity = false
end

admin_rol = Role.find_or_create_by!(name: 'ADMINISTRADOR') do |rol|
    rol.name = 'ADMINISTRADOR'
    rol.description = 'Administrador del sistema'
end

UserRole.find_or_create_by!(user: admin_user, role: admin_rol)

Role.find_or_create_by!(name: 'VACUNADOR') do |rol|
    rol.name = 'VACUNADOR'
    rol.description = 'Vacunador'
end

Role.find_or_create_by!(name: 'CIUDADANO') do |rol|
    rol.name = 'CIUDADANO'
    rol.description = 'Ciudadano'
end

Role.find_or_create_by!(name: 'DIRECTIVO') do |rol|
    rol.name = 'DIRECTIVO'
    rol.description = 'Médico'
end
