
class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new 

    if user.admin?
      can :manage, :all
    else
      can :update,Tournament do |tournament|
        tournament.user == user
      end

      can :destroy,Tournament do |tournament|
        tournament.user == user
      end

      can :update,Team do |team|
        team.user == user
      end
      can :update,Team do |team|
        team.user == user
      end

      can :index, Tournament
      can :index, Team
    end
  end
end







