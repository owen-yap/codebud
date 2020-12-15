class OrdersController < ApplicationController
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
      @video_tokens[User.find_by(email: token.identity)] =
        {
          token: token,
          room: "video-#{@order.id}"
        }
    end

    # Generate the token
  end

  private

  def set_proposal_id
    params.require(:order).permit(:proposal_id)[:proposal_id]
  end

  def setup_tokens
  end
end
