class SessionsController < ApplicationController
  def index
    @session = []
    @user = User.find(params[:id])
    @questions = @user.questions

    @questions.each do |question|
      if question.selected_proposal
        @proposal = question.selected_proposal
        if @proposal.order.completed?
          @session << @proposal
        end
      end
    end
    return @session
  end
end
