require "rails_helper"

RSpec.describe "Users", type: :request do
  describe "GET /users" do
    it "returns and array of users" do
      coverage = Coverage.create(cover_type: "International")
      user = User.create(
        first_name: "Eddy",
        last_name: "Munster",
        email: "eddymunster@email.com",
        password: "password",
        title: "Television Actor",
        city: "Los Angeles",
        state: "CA",
        phone: "555-555",
        profile_img: "eddymunsterimg.com",
        ed: "Highschool",
        desc: "I am known for creepy things.",
        coverage_id: coverage.id,
        linkd: "linkedin-eddy-munster.com",
        faceb: "facebook-eddy-munster.com",
        insta: "instagram-eddy-munster.com",
        active: true,
      )
      get "/api/users"
      users = JSON.parse(response.body)
      expect(response).to have_http_status(200)
      expect(users[0]["first_name"]).to eq("Eddy")
      expect(users[0]["title"]).to eq("Television Actor")
      expect(users[0]["active"]).to eq(true)
      # expect(users[0]["coverage_id"]).to eq(coverage.id)
    end
  end

  describe "GET /users/:id" do
    it "returns a hash/object of information for a single user" do
      coverage = Coverage.create(cover_type: "International")
      user = User.create(
        first_name: "Eddy",
        last_name: "Munster",
        email: "eddymunster@email.com",
        password: "password",
        coverage_id: coverage.id,
      )
      get "/api/users/#{user.id}"
      single_user = JSON.parse(response.body)
      expect(response).to have_http_status(200)
      expect(single_user["first_name"]).to eq("Eddy")
      expect(single_user["email"]).to eq("eddymunster@email.com")
    end
  end
end
