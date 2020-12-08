class BiosController < ApplicationController
  def new
    @bio = Bio.new
    @skill = Skill.new
  end

  def create
    @bio = Bio.new(params_bio)
    skill = Skill.new(params[:id])
    @bio.user = current_user
    @skill = current_user.skills
    @bio.save!
    redirect_to root_path
  end

  def edit; end

  def update; end

  private

  def params_bio
    params.require(:bio).permit(:content)
  end
end