module ActsPermissive
  class Circle < ActiveRecord::Base

    belongs_to :circleable, :polymorphic => true
    has_many :memberships
    has_many :users,        :through => :memberships

    before_create :create_guid
    validates_uniqueness_of :name, :guid

    scope :by_user, lambda { |user|
      joins(:memberships).where('memberships.user_id = ?', user.id).select("DISTINCT `circles`.*")
    }
    scope :by_role, lambda { |role|
      joins(:memberships).where('memberships.role_id = ?', role.id).select("`circles`.*")
    }
    scope :by_user_id, lambda { |user_id|
      joins(:memberships).where('memberships.user_id = ?', user_id).select("DISTINCT `circles`.*")
    }
    scope :by_role_id, lambda { |role_id|
      joins(:memberships).where('memberships.role_id = ?', role_id).select("`circles`.*")
    }
    scope :by_hidden, lambda { |hidden|
      where('is_hidden = ?', hidden)
    }

    def create_guid
      self.guid = UUIDTools::UUID.random_create.to_str
    end

    def add_user_as_role user, role
      Membership.create(:user => user, :role => role, :circle => self) unless user.is_role_in_circle? role, self
    end

    def owners
      User.owners_of_circle(self)
    end
    def admins
      User.admins_of_circle(self)
    end
    def readers
      User.readers_of_circle(self)
    end
    def writers
      User.writers_of_circle(self)
    end

  end
end