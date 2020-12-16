class ReviewsController < ApplicationController
  def new
    @order = Order.find(params[:order_id])
    @proposal = @order.proposal
    @review = Review.new
  end

  def create
    review = Review.new(review_params)
    @order = Order.find(params[:order_id])
    review.order = @order
    if review.save!
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def review_params
    params.require(:review).permit(:content, :rating)
  end
end
