class OrdersController < ApplicationController
  def update
    order = Order.find(params[:id])
    order.update(order_params)
    order.proposal.update(status: "completed")
    order.proposal.question.update(status: "answered")
    authorize order
    redirect_to question_messages_path(order.proposal.question)
  end

  def create_room
    @order = Order.find(params[:id])
    account_sid = ENV['TWILIO_ACCOUNT_SID']
    api_key = ENV['TWILIO_API_KEY']
    api_secret = ENV['TWILIO_API_SECRET']
    student = @order.proposal.question.user
    tutor = @order.proposal.user

    tokens = []
    @video_tokens = {}
    # Create an Access Token
    tokens << Twilio::JWT::AccessToken.new(account_sid, api_key, api_secret, [], identity: student.email)
    tokens << Twilio::JWT::AccessToken.new(account_sid, api_key, api_secret, [], identity: tutor.email)

    # Create Video grant for our token
    grant = Twilio::JWT::AccessToken::VideoGrant.new
    grant.room = "video-#{@order.id}"

    tokens.each do |token|
      token.add_grant(grant)
      @video_tokens[User.find_by(email: token.identity).id] =
        {
          token: token,
          room: "video-#{@order.id}"
        }
    end
    # Generate the token
  end

  def create
    proposal = Proposal.find(params[:order][:proposal_id])
    proposal.order.destroy
    order = Order.new(order_params)
    # add the proposal on the params to the right order
    # intiate the payment
    order.save!
    authorize order

    if order.proposal.price.zero?
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

  private

  def order_params
    params.require(:order).permit(:status, :proposal_id)
  end

  def setup_tokens
  end
end
