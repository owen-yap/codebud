class OrdersController < ApplicationController

  def create
    # create an order
    # order = Order.new
    # order.proposal = Proposal.find(set_proposal_id)
    # # add the proposal on the params to the right order
    # # intiate the payment

    # session = Stripe::Checkout::Session.create(
    #   payment_method_types: ['card'],
    #   line_items: [{
    #     name: order.proposal.question,
    #     amount: order.proposal.price_cents,
    #     currency: 'sgd',
    #     quantity: 1
    #   }],
    #   success_url: root_url,
    #   cancel_url: questions_url
    # )
    # order.save!
    # # binding.pry
    # order.update(session_id: session.id)
    # redirect_to new_order_payment_path(order)
  end


  private 

  def set_proposal_id
    params.require(:order).permit(:proposal_id)[:proposal_id]
  end
end
