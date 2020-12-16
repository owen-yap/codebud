class OrderPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def update?
    record.payer == user
  end

  def create_room?
    record.payer == user || record.proposal.user == user
  end
end
