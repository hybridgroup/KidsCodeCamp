class AdminAbility
  include CanCan::Ability

  def initialize(user)
    if user
      if user.is_admin == 1
        can :manage, :all
      else
        can :read, :all
        can [:new, :create], Post
        can [:edit, :update, :destroy], Post, :user_id => user.id
      end
    end
  end
end