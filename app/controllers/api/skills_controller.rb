class Api::SkillsController < ApplicationController
  before_action :authenticate_user

  def index
    @skills = Skill.all
    render "index.json.jb"
  end

  def create
    @skill = Skill.new(
      name: params[:name],
    )
    if @skill.save
      render "show.json.jb"
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show
    @skill = Skill.find(params[:id])
    render "show.json.jb"
  end
end
