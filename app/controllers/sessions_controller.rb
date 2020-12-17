class SessionsController < ApplicationController
  def index
    @session = []
    @user = User.find(params[:id])

    # if it is a tutor there are only proposals of questions
    if @user.tutor

      @proposals = @user.proposals
      @proposals.each do |proposal|
        if proposal.status == "selected" && proposal.order && proposal.order.completed?
          @session << proposal
        end
      end

    else
      # if it is a student there are only completed question asked
      @questions = @user.questions
      @questions.each do |question|
        if question.selected_proposal && question.selected_proposal.order
          @proposal = question.selected_proposal
            if @proposal.order.completed?
              @session << @proposal
            end
        end
      end
    end

    return @session
  end
end
