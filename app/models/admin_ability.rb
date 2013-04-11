class AdminAbility
  include CanCan::Ability

  def initialize(user)
    if user && user.is_admin?
      can :access, :rails_admin
      can :dashboard
      can :manage, :all
    end
    cannot :show_in_app, User
    cannot [:destroy,:new,:create], Editpage
  end
end