class Api::CalendarsController < ApplicationController
  before_action :authenticate_user

  def create
    @calendar = Calendar.new(
      user_id: current_user.id,
      avail: params[:availability],
      start_date: params[:start_date],
      end_date: params[:end_date],
    )
    if @calendar.save
      render "show.json.jb"
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show
    @calendar = Calendar.find(params[:id])
    render "show.json.jb"
  end

  def update
    @calendar = Calendar.find(params[:id])
    if @calendar.user_id == current_user.id
      @calendar.avail = params[:availability] || @calendar.avail
      @calendar.start_date = params[:start_date] || @calendar.start_date
      @calendar.end_date = params[:end_date] || @calendar.end_date
      if @calendar.save
        render "show.json.jb"
      else
        render json: { errors: @post.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: {}, status: :unauthorized
    end
  end

  def destroy
    @calendar = Calendar.find(params[:id])
    if @calendar.user_id == current_user.id
      @calendar.destroy
      render json: { message: "Calendar entry deleted", id: @calendar.id }
    else
      render json: {}, status: :unauthorized
    end
  end
end
