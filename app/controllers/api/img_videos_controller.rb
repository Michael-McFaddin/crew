class Api::ImgVideosController < ApplicationController
  before_action :authenticate_user

  def create
    @img_video = ImgVideo.new(
      user_id: current_user.id,
      # user_id: params[:user_id],
      url: params[:url],
      media_type: params[:media_type],
    )
    if @img_video.save
      render "show.json.jb"
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show
    @img_video = ImgVideo.find(params[:id])
    render "show.json.jb"
  end

  def destroy
    @img_video = ImgVideo.find(params[:id])
    if @img_video.user_id == current_user.id
      @img_video.destroy
      render json: { message: "Image or Video deleted", id: @img_video.id }
    else
      render json: {}, status: :unauthorized
    end
  end
end
