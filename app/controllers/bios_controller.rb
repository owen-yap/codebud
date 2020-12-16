class BiosController < ApplicationController
  def new
    @bio = Bio.new
    @skill = Skill.new
    authorize @bio
  end

  def create
    @bio = Bio.new(params_bio)
    @bio.user = current_user
    authorize @bio
    @bio.save!
    # extract an array of skills_ids from param
    skill_ids = params[:bio][:user][:skill_ids]
    # iterate thru array to get skill_id
    skill_ids.each do |skill_id|
      next if skill_id.empty?

      user_skill = UserSkill.new(user: current_user)
      user_skill.skill = Skill.find(skill_id.to_i)
      user_skill.save!
    end
    redirect_to root_path
  end

  def update
    @bio = Bio.find(params[:id])
    authorize @bio
    @bio.update(params_bio)
    redirect_to account_path
  end

  private

  def params_bio
    params.require(:bio).permit(:content)
  end
end
