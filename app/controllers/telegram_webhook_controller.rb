class TelegramWebhookController < ApplicationController
  skip_before_action :verify_authenticity_token
  skip_before_action :authenticate_user!

  def index
    url = "https://api.telegram.org/bot#{ENV['TELEGRAM_KEY']}/sendMessage"
    chat_id = params["message"]["from"]["id"]
    name = params["message"]["from"]["first_name"]
    message = params["message"]["text"]
    reply = ""
    case message
    when /start/i
      reply = "☺ Hi #{name}! Welcome to Codebud \n\n 🔔To start receiving notifications everytime a tutor applies for your question or replies you, tell me your codebud username"
    else
      if User.find_by(username: message)
        User.find_by(username: message).update(chat_id: chat_id)
        reply = "Account linked! You can now receive notifications from codebud! Start asking and push on 💪"
      else
        reply = "Sorry, I could not find your username :(\n\nYou may find your username under account details from your dashboard."
      end
    end
    p message
    HTTParty.post(url, body: {
                    chat_id: chat_id,
                    text: reply,
                    parse_mode: "HTML"
                  })
    respond_to do |format|
      format.json { render json: { hello: "webhook received" } }
      format.html
    end
  end
end
