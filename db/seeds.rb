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

VaccinationCenter.find_or_create_by!(name: 'Centro de Vacunación 1') do |center|
    center.address = 'Calle 1'
end

VaccinationCenter.find_or_create_by!(name: 'Centro de Vacunación 2') do |center|
    center.address = 'Calle 2'
end

VaccinationCenter.find_or_create_by!(name: 'Centro de Vacunación 3') do |center|
    center.address = 'Calle 3'
end

Campaign.find_or_create_by!(name: 'Campaña 1') do |campaign|
    campaign.description = 'Campaña 1 de prueba'
    campaign.start_date = "2020-01-01"
    campaign.end_date = "2020-12-31"
end

Campaign.find_or_create_by!(name: 'Campaña 2') do |campaign|
    campaign.description = 'Campaña 2 de prueba'
    campaign.start_date = "2020-01-01"
    campaign.end_date = "2020-12-31"
end

Campaign.find_or_create_by!(name: 'Campaña 3') do |campaign|
    campaign.description = 'Campaña 3 de prueba'
    campaign.start_date = "2020-01-01"
    campaign.end_date = "2020-12-31"
end
Turn.find_or_create_by!(status: 0) do |turn|
    turn.date=Date.today
    turn.user_id=1
    turn.campaign_id=1
    turn.vaccination_center_id=1

end
Turn.find_or_create_by!(status: 0) do |turn|
    turn.date=Date.today
    turn.user_id=1
    turn.campaign_id=3
    turn.vaccination_center_id=1

end

Turn.find_or_create_by!(status: 1) do |turn|
    turn.date=Date.today+1.day
    turn.user_id=1
    turn.campaign_id=2
    turn.vaccination_center_id=1

end

Turn.find_or_create_by!(status: 1) do |turn|
    turn.date=Date.today+1.day
    turn.user_id=1
    turn.campaign_id=3
    turn.vaccination_center_id=1

end