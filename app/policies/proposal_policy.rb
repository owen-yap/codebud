class ProposalPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(user: user)
    end
  end

  def new?
    return true
  end

  def create?
    return true
  end

  def cancel?
    record.question.user == user
  end

  def accept?
    record.question.user == user
  end
end
