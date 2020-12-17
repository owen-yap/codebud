class MessagePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    # the author of the message is either the tutor or the current user
    record.question.user == user ||
      record.question.selected_proposal.user == user
  end
end
