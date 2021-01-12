class QuestionsController < ApplicationController
  before_action :set_question, only: %i[show edit update destroy]

  include Pagy::Backend

  def index
    @questions = current_user.questions.where(status: ["pending", "in progress"])
    @proposals = current_user.proposals.where(status: %w[pending selected rejected])
    if params[:query].present?
      @pagy, @all_questions = pagy(Question.where(status: "pending").global_search(params[:query]), items: 3)
    else
      @pagy, @all_questions = pagy(Question.where(status: "pending"), items: 3)
    end
    @order = Order.new
  end

  def new
    @question = Question.new
    authorize @question
  end

  def create
    @question = Question.new(params_qn)
    @question.user = current_user
    authorize @question
    if @question.save!
      redirect_to question_path(@question)
      url = "https://api.telegram.org/bot#{ENV['TELEGRAM_KEY']}/sendMessage"
      message = "New Question 🖐\n\n ◼<b>Question:</b> #{@question.title}\n\n ◼<b>Topics</b>: #{@question.skills.pluck(:name).join(' ')}\n\n ◼<b>Availability:</b> #{unless @question.start_time.nil?
                                                                                                                                                                      @question.start_time.strftime('%A , %e %B %Y, %l:%M %P')
                                                                                                                                                                    end}\n#{unless @question.end_time.nil?
                                                                                                                                                                              @question.end_time.strftime('%A , %e %B %Y, %l:%M %P')
                                                                                                                                                                            end}\n\n Apply for this question now at https://codebud.co on your desktop"
      HTTParty.post(url, body: {
                      chat_id: "@codebud_tutors",
                      text: message,
                      parse_mode: "HTML"
                    })
    else
      render :new
    end
  end

  def show
    authorize @question
    @proposal = Proposal.new
    @proposal.question = @question
  end

  def edit
    authorize @question
  end

  def update
    authorize @question
    if @question.update(params_qn)
      redirect_to question_path(@question)
    else
      render :edit
    end
  end

  def destroy
    authorize @question
    @question.destroy
    redirect_to questions_path
  end

  private

  def set_question
    @question = Question.find(params[:id])
  end

  def params_qn
    params.require(:question).permit(:title, :rich_body,
                                     :start_time, :end_time, :user_id, skill_ids: [])
  end
end
