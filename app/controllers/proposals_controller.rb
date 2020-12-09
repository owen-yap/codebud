class ProposalsController < ApplicationController
  def index
    @proposals = Question.find(params[:id]).proposals
    raise
  end

  def new
  end

  def create
  end
end
