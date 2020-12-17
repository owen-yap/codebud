class ReviewsController < ApplicationController
  def index
    @bio = User.find(params[:user_id]).bio
    @skill_array = User.find(params[:user_id]).skills
    @average_rating = User.find(params[:user_id]).average_rating
    @user = User.find(params[:user_id])
  end

  def new
    @order = Order.find(params[:order_id])
    @proposal = @order.proposal
    @review = Review.new
    @review.order = @order

    authorize @review
  end

  def create
    @review = Review.new(review_params)
    @order = Order.find(params[:order_id])
    @review.order = @order
    @user = Order.find(params[:order_id]).proposal.user
    @review.user = @user

    authorize @review
    if @review.save!
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
