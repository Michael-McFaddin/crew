require "rails_helper"

RSpec.describe "Categories", type: :request do

  # before action creation of coverage and user

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
    categories = Category.create([
      { name: "Audio" },
      { name: "Lighting" },
      { name: "Production" },
      { name: "Operations" },
      { name: "Tour Management" },
      { name: "Photography/Videography" },
      { name: "Stage Tech" },
      { name: "Artist Relations" },
      { name: "Hospitality" },
    ])
  end

  # categories index test

  describe "GET /categories" do
    it "should return an array of categories, 9 total" do
      jwt = JWT.encode({ user_id: User.first.id }, Rails.application.credentials.fetch(:secret_key_base), "HS256")
      get "/api/categories",
        headers: { "Authorization" => "Bearer #{jwt}" }
      categories = JSON.parse(response.body)
      expect(response).to have_http_status(200)
      expect(categories[0]["name"]).to eq("Audio")
      expect(categories.length).to eq(9)
    end
  end

  # categories show test

  describe "GET /categories/:id" do
    it "should return a single category" do
      jwt = JWT.encode({ user_id: User.first.id }, Rails.application.credentials.fetch(:secret_key_base), "HS256")
      get "/api/categories/#{Category.last.id}",
        headers: { "Authorization" => "Bearer #{jwt}" }
      category = JSON.parse(response.body)
      expect(response).to have_http_status(200)
      expect(category["name"]).to eq("Hospitality")
    end
  end
end
