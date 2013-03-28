class Ability
  include CanCan::Ability

  def initialize(user)
    if user
      can :access, :rails_admin
      can :dashboard              # grant access to the dashboard
      if user.is_admin == 1
        can :manage, :all
      else
        can [:new, :create, :index], Post
        can [:edit, :update, :destroy], Post, :user_id => user.id
      end
    end
  end
end