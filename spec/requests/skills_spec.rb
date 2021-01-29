require "rails_helper"

RSpec.describe "Skills", type: :request do

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
    skills = Skill.create([
      { name: "Forklift Certification" },
      { name: "Rough Terrain Forklift Certification" },
      { name: "Meyer 120" },
      { name: "CDL Class A" },
      { name: "Gobo light products" },
      { name: "Gibson Guitar technician" },
    ])
  end

  # skills index test

  describe "GET /skills" do
    it "should return an array of all available skills" do
      jwt = JWT.encode({ user_id: User.first.id }, Rails.application.credentials.fetch(:secret_key_base), "HS256")
      get "/api/skills",
        headers: { "Authorization" => "Bearer #{jwt}" }
      skills = JSON.parse(response.body)
      expect(response).to have_http_status(200)
      expect(skills[0]["name"]).to eq("Forklift Certification")
      # expect(users[0]["title"]).to eq("Television Character")
      # expect(users[0]["active"]).to eq(true)
    end
  end

  # skills create test

  describe "POST /skills" do
    it "should create a new skill and return a hash/object of the created skill info" do
      jwt = JWT.encode({ user_id: User.first.id }, Rails.application.credentials.fetch(:secret_key_base), "HS256")
      post "/api/skills",
        params: { name: "Tech Lighting Board Operator" },
        headers: { "Authorization" => "Bearer #{jwt}" }
      new_skill = JSON.parse(response.body)
      expect(response).to have_http_status(200)
      expect(new_skill["name"]).to eq("Tech Lighting Board Operator")
    end
  end

  # skills show test

  describe "GET /skills/:id" do
    it "should return a single skill" do
      jwt = JWT.encode({ user_id: User.first.id }, Rails.application.credentials.fetch(:secret_key_base), "HS256")
      get "/api/skills/#{Skill.last.id}",
        headers: { "Authorization" => "Bearer #{jwt}" }
      skill = JSON.parse(response.body)
      expect(response).to have_http_status(200)
      expect(skill["name"]).to eq("Gibson Guitar technician")
      # expect(users[0]["title"]).to eq("Television Character")
      # expect(users[0]["active"]).to eq(true)
    end
  end
end
