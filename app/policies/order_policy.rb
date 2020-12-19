class OrderPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def new?
    record.payer == user
  end

  def update?
    record.payee == user || record.payer == user
  end

  def create_room?
    record.payee == user || record.payer == user
  end

  def create?
    record.payer == user
  end
end
