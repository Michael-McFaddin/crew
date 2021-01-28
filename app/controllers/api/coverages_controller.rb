class Api::CoveragesController < ApplicationController
  before_action :authenticate_user

  def index
    @coverages = Coverage.all
    render "index.json.jb"
  end
end
