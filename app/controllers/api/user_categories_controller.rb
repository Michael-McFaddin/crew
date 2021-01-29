class Api::UserCategoriesController < ApplicationController
  before_action :authenticate_user

  def create
    @user_category = UserCategory.new(
      user_id: current_user.id,
      category_id: params[:category_id],
    )
    if @user_category.save
      render "show.json.jb"
    else
      render json: { errors: @user_category.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @user_category = UserCategory.find(params[:id])
    if @user_category.user_id == current_user.id
      @user_category.destroy
      render json: { message: "User Category destroyed", id: @user_category.id }
    else
      render json: {}, status: :unauthorized
    end
  end
end
