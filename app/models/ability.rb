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
    else 
      can :read, Tournament
      can :read, Team

    end
  end
end
































































































# class Ability
#   include CanCan::Ability

#   def initialize(user)
#     user ||= User.new 

#     if user.admin?
#       can :manage, :all
#     else
#       can :update,Tournament do |tournament|
#         tournament.user == user
#       end

#       can :destroy,Tournament do |tournament|
#         tournament.user == user
#       end

#       can :update,Team do |team|
#         team.user == user
#       end
#       can :update,Team do |team|
#         team.user == user
#       end
#     elsif user.tournament_owner?
#       can :manage, :all
#       # can :index, Tournament
#     elsif user.team_owner?
#       # can :index, Team
#       can :manage, :all
#       can :index, Tournament
#       can :index, Team
#     end
#   end
# end










