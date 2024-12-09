# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user

    if user.has_role?(:admin)
      can :manage, :all
    elsif user.has_role?(:manager)
      can :manage, Sale
      can :manage, Product
      can :manage, Category
      can :create, User
      can :manage, User, roles: { name: [ "manager", "employee" ] }
      cannot :create, User, roles: { name: "admin" }
      cannot :manage, User, roles: { name: "admin" }
    elsif user.has_role?(:employee)
      can :manage, Sale
      can :manage, Product
      can :manage, Category
      can :show, User, id: user.id
      can :update, User, id: user.id
    end
  end
end
