class Api::CategoriesController < ApplicationController
  before_action :authenticate_user

  def index
    @categories = Category.all
    render "index.json.jb"
  end

  def show
    @category = Category.find(params[:id])
    render "show.json.jb"
  end
end
