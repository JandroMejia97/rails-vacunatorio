module RolesHelper
    def has_role?(role_name, user = current_user)
        return false if user.nil?
        if (role_name.kind_of?(Array))
            role_name.map! { |role| role.upcase }
        else
            role_name = [role_name.upcase]
        end

        return UserRole.joins(:role).where("user_id = ? AND roles.name in (?)", user.id, role_name).exists?
    end

    def is_organization_member?(user = current_user)
        return false if user.nil?
        return has_role?([:vacunador, :directivo, :administrador], user)
    end
    
end