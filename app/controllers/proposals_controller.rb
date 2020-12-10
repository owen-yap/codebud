class ProposalsController < ApplicationController
  def index
    @question = Question.find(params[:question_id])
    @proposals = @question.proposals
  end

  def new
  end

  def create
  end

  def accept
    @accepted_proposal = Proposal.find(params[:proposal][:id].to_i)

    @question = @accepted_proposal.question

    @allproposals = @question.proposals

    @allproposals.each do |proposal|
      if proposal == @accepted_proposal
        @accepted_proposal.status = "selected"
        @accepted_proposal.save!
      else
        proposal.status = "rejected"
        proposal.save!
      end
    end
    # go to order path when it is created
    redirect_to questions_path
  end


  # def set_proposal
  #   @proposal = Proposal.find(params[:id])
  # end
end
