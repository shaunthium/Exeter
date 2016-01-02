module Groupable
    extend ActiveSupport::Concern

    included do
        has_many :memberships, foreign_key: "member_id",
                                dependent: :destroy
        has_many :groups, through: :memberships
    end

    # Adds member to group
    def add_to_group(group)
        self.memberships.create(group_id: group.id)
    end

    # Removes member from group
    def remove_from_group(group)
        self.memberships.find_by(group_id: group.id).destroy!
    end
end
