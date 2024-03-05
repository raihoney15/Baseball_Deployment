class Ability
  include CanCan::Ability

  def initialize(user)

    user ||= User.new 
  
    if user.roles.exists?(role_name:'admin')
      can :manage, :all
    elsif user.roles.exists?(role_name:'tournament_owner') || user.roles.exists?(role_name:'team_owner')

      can :manage, Tournament, user: user
      can :manage, Team, user: user
      can :manage, OpponentTeam, user: user
      can :manage, Rooster, user: user
      can :manage, OpponentRooster, user: user
      can :manage, Event, user: user
      can :manage, TeamLineUp, user: user
      can :manage, OpponentTeamLineUp, user: user
    else 
      can :read, Tournament
      can :read, Team
      can :read, Event
      can :read, OpponentTeam
      can :read, TeamLineUp
      can :read, OpponentTeamLineUp

    end
          
  if user.roles.exists?(role_name:'tournament_admin') 
    can :show, Tournament
    can :read, Tournament
    can :edit, Tournament
    can :update, Tournament
    can :create, Tournament
  end
  end
end









































































































