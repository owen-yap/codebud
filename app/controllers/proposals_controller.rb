class ProposalsController < ApplicationController
  def index
    @question = Question.find(params[:question_id])
    @proposals = @question.proposals
  end

  def new
  end

  def create
  end
end
