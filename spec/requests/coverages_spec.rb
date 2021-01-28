require "rails_helper"

RSpec.describe "Coverages", type: :request do
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
  end

  describe "GET /coverages" do
    it "should return an array of all available coverages" do
      jwt = JWT.encode({ user_id: User.first.id }, Rails.application.credentials.fetch(:secret_key_base), "HS256")
      get "/api/coverages",
        headers: { "Authorization" => "Bearer #{jwt}" }
      coverages = JSON.parse(response.body)
      expect(response).to have_http_status(200)
      expect(coverages[0]["cover_type"]).to eq("International")
      # expect(users[0]["title"]).to eq("Television Character")
      # expect(users[0]["active"]).to eq(true)
    end
  end
end
