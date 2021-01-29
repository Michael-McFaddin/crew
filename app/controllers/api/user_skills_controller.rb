class Api::UserSkillsController < ApplicationController
  before_action :authenticate_user

  def create
    @user_skill = UserSkill.new(
      # user_id: params[:user_id],
      user_id: current_user.id,
      skill_id: params[:skill_id],
    )
    if @user_skill.save
      render "show.json.jb"
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @user_skill = UserSkill.find(params[:id])
    if @user_skill.user_id == current_user.id
      @user_skill.destroy
      render json: { message: "User Skill destroyed", id: @user_skill.id }
    else
      render json: {}, status: :unauthorized
    end
  end
end
