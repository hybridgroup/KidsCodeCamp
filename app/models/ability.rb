class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, :all
    can :about, :pages #TEST
    if user
      can [:new, :create, :index], Post
      if user.is_admin?
        can [:edit, :update, :destroy], Post, :user_id => user.id
      else
        can [:edit, :update, :destroy], Post
      end
    end
  end
end