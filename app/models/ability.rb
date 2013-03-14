class Ability
  include CanCan::Ability

  def initialize(user)
    if user
      if user.is_admin
        can :manage, :all
      else
        can :read, [Post]
        can :manage, Post do |post|
          post.try(:owner) == user
        end
      end
    else
      can :read, :all
    end
  end
end