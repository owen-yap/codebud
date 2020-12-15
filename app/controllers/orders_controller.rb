class OrdersController < ApplicationController

  def create

  end

  def update
    order = Order.find(params[:id])
    order.update(order_params)
    redirect_to question_messages_path(order.proposal.question)
  end

  private
  
  def order_params
    params.require(:order).permit(:status)
  end
end
