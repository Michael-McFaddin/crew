require "rails_helper"

RSpec.describe "UserSkills", type: :request do

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
    user_skill = UserSkill.create([
      {
        user_id: user.id,
        skill_id: skills[0].id,
      },
    ])
  end

  # user_skills create test

  describe "POST /user_skills" do
    it "should create an association to user and skill" do
      jwt = JWT.encode({ user_id: User.first.id }, Rails.application.credentials.fetch(:secret_key_base), "HS256")
      post "/api/user_skills",
        params: {
          skill_id: Skill.first.id,
        },
        headers: { "Authorization" => "Bearer #{jwt}" }
      user_skill = JSON.parse(response.body)
      expect(response).to have_http_status(200)
      expect(user_skill["user_id"]).to eq(User.first.id)
      expect(user_skill["skill_id"]).to eq(Skill.first.id)
    end
  end

  # user_skills destroy test

  describe "DELETE /user_skills/:id" do
    it "should delete a user_skill and return a message and id" do
      jwt = JWT.encode({ user_id: User.first.id }, Rails.application.credentials.fetch(:secret_key_base), "HS256")
      delete "/api/user_skills/#{UserSkill.first.id}",
        headers: { "Authorization" => "Bearer #{jwt}" }
      deleted_user_skill = JSON.parse(response.body)
      expect(response).to have_http_status(200)
      expect(deleted_user_skill["message"]).to eq("User Skill destroyed")
    end
  end
end
