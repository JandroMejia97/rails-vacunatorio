module RolesHelper
    def has_role?(role_name, user = current_user)
        return false if user.nil?
        role_name = role_name.upcase
        role = Role.where(name: role_name).first
        return UserRole.where(:user_id => user.id, :role_id => role.id).exists?
    end
    
    def is_organization_member?(user = current_user)
        return false if user.nil?
        return has_role?(:vacunador, user) || has_role?(:directivo, user) || has_role?(:administrador, user)
    end
    
end