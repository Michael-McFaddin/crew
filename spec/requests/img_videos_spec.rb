require "rails_helper"

RSpec.describe "ImgVideos", type: :request do
  before do
    coverage = Coverage.create(cover_type: "International")
    user = User.create(
      first_name: "Eddy",
      last_name: "Munster",
      email: "eddymunster@email.com",
      password: "password",
      title: "Television Character",
      coverage_id: coverage.id,
      active: true,
    )
    img = ImgVideo.create(
      user_id: user.id,
      url: "www.someimageorvideo.com",
      media_type: "image",
    )
  end

  # img_videos create test

  describe "POST /img_videos" do
    it "should create an img_video and return a show hash/object" do
      jwt = JWT.encode({ user_id: User.first.id }, Rails.application.credentials.fetch(:secret_key_base), "HS256")
      post "/api/img_videos",
        params: {
          user_id: User.first.id,
          url: "https://somevideo.com",
          media_type: "image",
        },
        headers: { "Authorization" => "Bearer #{jwt}" }
      image = JSON.parse(response.body)
      expect(response).to have_http_status(200)
      expect(image["user_id"]).to eq(User.first.id)
      expect(image["url"]).to eq("https://somevideo.com")
      expect(image["media_type"]).to eq("image")
    end
  end

  # img_videos show test

  describe "Get /img_videos/:id" do
    it "should return a single img_video" do
      jwt = JWT.encode({ user_id: User.first.id }, Rails.application.credentials.fetch(:secret_key_base), "HS256")
      get "/api/img_videos/#{ImgVideo.first.id}",
        headers: { "Authorization" => "Bearer #{jwt}" }
      imgvideo = JSON.parse(response.body)
      expect(response).to have_http_status(200)
      expect(imgvideo["user_id"]).to eq(User.first.id)
      expect(imgvideo["url"]).to eq("www.someimageorvideo.com")
      expect(imgvideo["media_type"]).to eq("image")
    end
  end
end
