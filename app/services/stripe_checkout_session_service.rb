class StripeCheckoutSessionService
  def call(event)
    order = Order.find_by(session_id: event.data.object.id)
    order.update(status: 'paid')
  end
end
