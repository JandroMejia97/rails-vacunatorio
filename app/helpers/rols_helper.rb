module RolsHelper
    def has_rol?(rol_name, user = current_user)
        return false if user.nil?
        rol_name = rol_name.upcase
        rol = Rol.where(name: rol_name).first
        return UserRol.where(:user_id => user.id, :rol_id => rol.id).exists?
    end
    
end