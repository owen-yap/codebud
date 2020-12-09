class SkillController < ApplicationController
  def show
    @skill = Skill.find(params[:id])
  end
end
