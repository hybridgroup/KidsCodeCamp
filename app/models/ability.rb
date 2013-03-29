class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, :all
    if user
      can [:new, :create], Post
      can [:edit, :update, :destroy], Post, :user_id => user.id
    end
  end
end