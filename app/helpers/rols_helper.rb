module RolsHelper
    def has_rol?(role_name, user = current_user)
        return false if user.nil?
        role_name = role_name.upcase
        role = Role.where(name: role_name).first
        return UserRole.where(:user_id => user.id, :role_id => role.id).exists?
    end

    def is_organization_member?(user = current_user)
        return false if user.nil?
        return has_rol?(:vacunador, user) || has_rol?(:directivo, user) || has_rol?(:administrador, user)
    end
    
end