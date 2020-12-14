class ProposalsController < ApplicationController
  def index
    @question = Question.find(params[:question_id])
    @proposals = @question.proposals
  end

  def new
  end

  def create
    proposal = Proposal.new(proposal_params)
    proposal.status = 'pending'
    proposal.user = current_user
    proposal.question = Question.find(params[:question_id])
    proposal.save!
    question = proposal.question
    if question.user.chat_id
      url = "https://api.telegram.org/bot1344893186:AAFwGnlTgTZyKzp-fjQIxIS4ZlyW-k3lOKQ/sendMessage"
      if question.proposals.count == 1
        message = "A tutor just applied for your question!"
      else
        message = "#{question.proposals.count} tutors have applied for your question!"
      end
      HTTParty.post(url, body: {
                      chat_id: question.user.chat_id,
                      text: message,
                      parse_mode: "HTML"
                    })
    end
    redirect_to questions_path
  end

  def cancel
    proposal = Proposal.find(params[:id])
    proposal.status = 'cancelled'
    proposal.save!
    redirect_to questions_path
  end

  def accept
    @accepted_proposal = Proposal.find(params[:proposal][:id].to_i)
    @question = @accepted_proposal.question

    @allproposals = @question.proposals

    @allproposals.each do |proposal|
      if proposal == @accepted_proposal
        @accepted_proposal.update(status: "selected")
      else
        proposal.update(status: "rejected")
      end
    end

    @question.update(status: "in progress")
    # go to order path when it is created
    redirect_to questions_path
  end

  def proposal_params
    params.require(:proposal).permit(:price, :status, :meeting_time)
  end
  # def set_proposal
  #   @proposal = Proposal.find(params[:id])
end
