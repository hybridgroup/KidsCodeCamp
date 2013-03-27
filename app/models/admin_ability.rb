class AdminAbility
  include CanCan::Ability

  def initialize(user)
    if user
      if user.is_admin == 1
        can :access, :rails_admin   # grant access to rails_admin
        can :dashboard              # grant access to the dashboard
        can :manage, :all
      else
        can [:new, :create], Post
        can [:edit, :update, :destroy], Post, :user_id => user.id
      end
    end
  end
end