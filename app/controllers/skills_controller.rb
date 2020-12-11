class SkillsController < ApplicationController
  def show
    @skill = Skill.find(params[:id])
  end

  def update
    current_user.skills.clear # destroy current skills
    array = params[:skillset][:user][:skillset] # get skill ids in an array
    array.each do |skill_id| # assign each new skill id to user and user
      next if skill_id.empty?

      user_skill = UserSkill.new
      skill = Skill.find(skill_id.to_i)
      user = User.find(current_user.id)
      user_skill.user = user
      user_skill.skill = skill
      user_skill.save!
    end
    redirect_to account_path
  end
end
