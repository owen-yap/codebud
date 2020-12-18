class SessionsController < ApplicationController
  def index
    @session = []
    @user = User.find(params[:id])

    # if it is a tutor there are only proposals of questions
    if @user.tutor

      @proposals = @user.proposals
      @proposals.each do |proposal|
        @session << proposal if proposal.status == "completed" && proposal.order && proposal.order.completed?
      end

    else
      # if it is a student there are only completed question asked
      @questions = @user.questions
      @questions.each do |question|
        next unless question.selected_proposal && question.selected_proposal.order

        @proposal = question.selected_proposal
        @session << @proposal if @proposal.order.completed?
      end
    end

    return @session
  end
end
