class SkillsController < ApplicationController
  def show
    @skill = Skill.find(params[:id])
  end

  def update

    current_user.skills.clear # destroy current skills
    array = params[:skillset][:user][:skillset] # get skill ids in an array

    array.each do |skill_id| # assign each new skill id to user and user
      next if skill_id.empty?
      # create new user_skill instance
      user_skill = UserSkill.new
      # find the skill based on the id
      skill = Skill.find(skill_id.to_i)
      # find the current user to associate data with
      user = User.find(current_user.id)
      # the user of the skillset is the current user
      user_skill.user = user
      # the skill belongs to the user
      user_skill.skill = skill
      authorize user_skill
      user_skill.save!
    end
    redirect_to account_path
  end
end
