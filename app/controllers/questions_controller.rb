class QuestionsController < ApplicationController
  before_action :set_question, only: %i[show edit update destroy]

  include Pagy::Backend

  def index
    @questions = current_user.questions.where(status: "pending")
    @proposals = current_user.proposals.where(status: %w[pending selected rejected])

    if params[:query].present?
      @pagy, @all_questions = pagy(Question.where(status: "pending").global_search(params[:query]), items: 3)
    else
      @pagy, @all_questions = pagy(Question.where(status: "pending"), items: 3)
    end
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(params_qn)
    @question.user = current_user
    if @question.save!
      redirect_to question_path(@question)
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @question.update(params_qn)
      redirect_to question_path(@question)
    else
      render :edit
    end
  end

  def destroy
    @question.destroy
    redirect_to questions_path
  end

  private

  def set_question
    @question = Question.find(params[:id])
  end

  def params_qn
    params.require(:question).permit(:title, :description, :min_price,
                                     :max_price, :start_time, :end_time, :user_id, skill_ids: [])
  end
end
