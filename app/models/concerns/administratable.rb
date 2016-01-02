module Administratable
    extend ActiveSupport::Concern

    included do
        has_many :adminships, foreign_key: "admin_id",
                                dependent: :destroy
        has_many :administrated_groups, class_name: "Group", through: :adminships
    end

    # Makes user admin of group
    def make_admin_of_group(group)
        self.adminships.create(administrated_group_id: group.id)
    end
end
