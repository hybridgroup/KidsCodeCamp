class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, :all
    if user
      can [:new, :create, :index], Post
      if user.is_admin?
        can [:edit, :update, :destroy], Post
      else
        can [:edit, :update, :destroy], Post, :user_id => user.id
      end
    end
  end
end