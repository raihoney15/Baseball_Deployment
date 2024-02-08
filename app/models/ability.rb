class Ability
  include CanCan::Ability

  def initialize(user)

    user ||= User.new 

    
    
    if user.roles.exists?(role_name:'admin')
      can :manage, :all
    elsif user.roles.exists?(role_name:'tournament_owner') || user.roles.exists?(role_name:'team_owner')
      # can :create, Tournament 
      # can :create, Team
      # can [:show, :read, :edit, :destroy], Tournament,  user: user
      # can [:read, :edit, :destroy], Team, user: user
      can :manage, Tournament, user: user
      can :manage, Team, user: user
      can :manage, OpponentTeam, user: user
      can :manage, Rooster, user: user
      can :manage, OpponentRooster, user: user
      can :manage, Event, user: user

    else 
      can :read, Tournament
      can :read, Team

    end
  end
end









































































































