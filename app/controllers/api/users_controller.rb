class Api::UsersController < ApplicationController
  before_action :authenticate_user, except: [:create]

  def index
    @users = User.all
    render "index.json.jb"
  end

  def create
    @user = User.new(
      first_name: params[:first_name],
      last_name: params[:last_name],
      email: params[:email],
      password: params[:password],
      # password_confirmation: params[:password_confirmation],
      coverage_id: 1,
      active: true,
    )
    if @user.save
      render "show.json.jb"
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show
    # @user = User.find(params[:id])
    @user = current_user
    render "show.json.jb"
  end

  def update
    # @user = User.find(params[:id])
    @user = current_user
    @user.first_name = params[:first_name] || @user.first_name
    @user.last_name = params[:last_name] || @user.last_name
    @user.email = params[:email] || @user.email
    @user.title = params[:title] || @user.title
    @user.city = params[:city] || @user.city
    @user.state = params[:state] || @user.state
    @user.phone = params[:phone] || @user.phone
    @user.profile_img = params[:profile_img] || @user.profile_img
    @user.ed = params[:ed] || @user.ed
    @user.desc = params[:desc] || @user.desc
    @user.coverage_id = params[:coverage_id] || @user.coverage_id
    @user.linkd = params[:linkd] || @user.linkd
    @user.faceb = params[:faceb] || @user.faceb
    @user.insta = params[:insta] || @user.insta
    if params[:password]
      @user.password = params[:password]
      @user.password_confirmation = params[:password_confirmation]
    end
    if @user.save
      render "show.json.jb"
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @user = current_user
    # @user = User.find(params[:id])
    @user.destroy
    render json: { message: "User successfully deleted!", id: @user.id }
  end
end
