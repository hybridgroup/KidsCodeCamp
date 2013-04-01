class AdminAbility
  include CanCan::Ability

  def initialize(user)
    if user && user.is_admin == 1
      can :access, :rails_admin
      can :dashboard              # grant access to the dashboard
      can :manage, :all
    end
    cannot :show, :all
  end
end