class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
       user ||= User.new # guest user (not logged in)
       if user.role? :admin
         can :manage, :all
       elsif user.role? :instructor
           # they can update their own profile
          can :update, Instructor do |u|  
            u.user.id == user.id
          end

          can :update, User do |u|  
            u.id == user.id
          end

          can :edit, Instructor do |u|  
            u.user.id == user.id
          end

          can :read, Instructor do |u|  
            u.user.id == user.id
          end

          can :read, Student do |s|  
            my_students = user.instructor.camps.map { |camp| camp.students}.flatten
            my_students.include? s

          end


         
       end
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
    # https://github.com/bryanrite/cancancan/wiki/Defining-Abilities
  end
end
