class Ability
  include CanCan::Ability
  
  def initialize(user)
    
    user ||= User.new # guest user (not logged in)
    
    if user.admin?
      
      # ADMIN
      can :manage, :all
      
    elsif user.customer?
      
      # CUSTOMER
      
      can :create, Site
      
      #manage own sites
      can :manage, Site, user: user
      
      # edit ideas
      #can :update, Idea, user: user, site: { user: user }
      
      # delete idea if it belongs to an owned site
      can :destroy, Idea do |idea|
        user.sites.include? idea.site
      end
      
      # delete comment if it belongs to an owned site
      can :destroy, Comment do |comment|
        user.sites.include? comment.idea.site
      end
      
      can :create, Response
      
      can :create, Vote
      
    else
      
      # VISITOR
      
      # delete own idea if no comment or response is attached
      can :destroy, Idea do |idea|
        idea.user == user && idea.comments.empty? && idea.responses.empty? && idea.votes.empty?
      end
      
      # delete own idea if no comments follow
      can :destroy, Comment do |comment|
        comment.user == user && comment.idea.comments.last == comment
      end
      
      # edit own ideas
      #can :update, Idea, user: user, editable?: true
      
      can :create, Vote
      
    end
    
    # EVERYBODY
    
    can :update, User, id: user.id
    
    can :create, Idea
    can :create, Comment
    
    can :read, Site
    can :read, Idea
    can :read, Comment
    can :read, User
    
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user 
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. 
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
