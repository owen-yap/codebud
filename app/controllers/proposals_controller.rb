class ProposalsController < ApplicationController
  def index
    @question = Question.find(params[:question_id])
    @proposals = @question.proposals
  end

  def new
  end

  def create
  end

  def cancel
    proposal = Proposal.find(params[:id])
    proposal.status = 'cancelled'
    proposal.save!
    redirect_to questions_path
  end
end
