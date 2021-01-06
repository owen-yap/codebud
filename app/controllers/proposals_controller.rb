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
    authorize proposal

    proposal.save!
    question = proposal.question
    if question.user.chat_id
      url = "https://api.telegram.org/bot#{ENV['TELEGRAM_KEY']}/sendMessage"
      message = "A tutor has just applied for your question! \n\n Included message: #{proposal.message}"
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
    authorize proposal
    proposal.save!
    redirect_to questions_path
  end

  def accept
    @accepted_proposal = Proposal.find(params[:order][:proposal_id].to_i)
    @question = @accepted_proposal.question

    @allproposals = @question.proposals

    @allproposals.each do |proposal|
      if proposal == @accepted_proposal
        authorize @accepted_proposal
        @accepted_proposal.update(status: "selected")
      else
        authorize proposal
        proposal.update(status: "rejected")
      end
    end

    @question.update(status: "in progress")

    create_order(@accepted_proposal)
  end

  private

  def create_order(proposal)
    # create an order
    order = Order.new
    order.proposal = proposal
    # add the proposal on the params to the right order
    # intiate the payment

    if proposal.price.zero?
      order.status = "paid"
      order.save!
      redirect_to root_path
      return
    end

    session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: [{
        name: order.proposal.question.title,
        amount: order.proposal.price_cents,
        currency: 'sgd',
        quantity: 1
      }],
      success_url: root_url,
      cancel_url: questions_url
    )
    order.save!
    order.update(session_id: session.id)
    redirect_to new_order_payment_path(order)
  end

  def proposal_params
    params.require(:proposal).permit(:price, :status, :meeting_time, :message)
  end
  # def set_proposal
  #   @proposal = Proposal.find(params[:id])
end
