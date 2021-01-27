require "rails_helper"

RSpec.describe "Users", type: :request do

  # users create test

  describe "Post /users" do
    it "should create a new user and return a hash/object of the created users info, status 200" do
      # coverage = Coverage.create(cover_type: "International")
      post "/api/users",
           params: {
             first_name: "Eddy",
             last_name: "Munster",
             email: "eddymunster@email.com",
             password: "password",
           #  coverage_id: coverage.id,
           }
      new_user = JSON.parse(response.body)
      expect(response).to have_http_status(200)
      expect(new_user["first_name"]).to eq("Eddy")
      expect(new_user["email"]).to eq("eddymunster@email.com")
    end
    it "no params should return an error status code of unprocessable_entity, 422" do
      # coverage = Coverage.create(cover_type: "International")
      post "/api/users", params: {}
      new_user = JSON.parse(response.body)
      expect(response).to have_http_status(422)
    end
  end

  # users index tests

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
      jwt = JWT.encode({ user_id: user.id }, Rails.application.credentials.fetch(:secret_key_base), "HS256")
      get "/api/users",
        headers: { "Authorization" => "Bearer #{jwt}" }
      users = JSON.parse(response.body)
      expect(response).to have_http_status(200)
      expect(users[0]["first_name"]).to eq("Eddy")
      expect(users[0]["title"]).to eq("Television Actor")
      expect(users[0]["active"]).to eq(true)
      # expect(users[0]["coverage_id"]).to eq(coverage.id)
    end
  end

  # user show tests

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
      jwt = JWT.encode({ user_id: user.id }, Rails.application.credentials.fetch(:secret_key_base), "HS256")
      get "/api/users/#{user.id}",
        headers: { "Authorization" => "Bearer #{jwt}" }
      single_user = JSON.parse(response.body)
      expect(response).to have_http_status(200)
      expect(single_user["first_name"]).to eq("Eddy")
      expect(single_user["email"]).to eq("eddymunster@email.com")
    end
    it "no jwt/authorization should return an error status code of unauthorized, 401" do
      coverage = Coverage.create(cover_type: "International")
      user = User.create(
        first_name: "Eddy",
        last_name: "Munster",
        email: "eddymunster@email.com",
        password: "password",
        coverage_id: coverage.id,
      )
      # coverage = Coverage.create(cover_type: "International")
      get "/api/users/#{user.id}"
      single_user = JSON.parse(response.body)
      expect(response).to have_http_status(401)
    end
  end

  # user update tests

  describe "PATCH /users" do
    it "should update a user and return updated user data" do
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
        # active: true,
      )
      jwt = JWT.encode({ user_id: user.id }, Rails.application.credentials.fetch(:secret_key_base), "HS256")
      patch "/api/users/#{user.id}",
            params: { city: "New City", state: "New State" },
            headers: { "Authorization" => "Bearer #{jwt}" }
      updated = JSON.parse(response.body)
      expect(response).to have_http_status(200)
      expect(updated["first_name"]).to eq("New City")
      expect(updated["title"]).to eq("New State")
    end
  end

  # describe "PATCH /users/:id" do
  #   it "should update a user and return a hash/object of updated user data" do
  #     coverage = Coverage.create(cover_type: "International")
  #     user = User.create(
  #       first_name: "Eddy",
  #       last_name: "Munster",
  #       email: "eddymunster@email.com",
  #       password: "password",
  #       title: "Television Actor",
  #       city: "Los Angeles",
  #       state: "CA",
  #       phone: "555-555",
  #       profile_img: "eddymunsterimg.com",
  #       ed: "Highschool",
  #       desc: "I am known for creepy things.",
  #       coverage_id: coverage.id,
  #       linkd: "linkedin-eddy-munster.com",
  #       faceb: "facebook-eddy-munster.com",
  #       insta: "instagram-eddy-munster.com",
  #       active: true,
  #     )
  #     jwt = JWT.encode({ user_id: user.id }, Rails.application.credentials.fetch(:secret_key_base), "HS256")
  #     patch "/api/users/#{user.id}",
  #       params: { city: "New City", state: "New State" },
  #       headers: { "Authorization" => "Bearer #{jwt}" }
  #     updated_user = JSON.parse(response.body)
  #     expect(response).to have_http_status(200)
  #     expect(updated_user["city"]).to eq("New City")
  #     expect(updated_user["state"]).to eq("New State")
  #   end
  # end
end
