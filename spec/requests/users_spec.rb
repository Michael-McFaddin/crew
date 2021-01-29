require "rails_helper"

RSpec.describe "Users", type: :request do

  # before action creation of user

  before do
    user = User.create(
      first_name: "Eddy",
      last_name: "Munster",
      email: "eddymunster@email.com",
      password: "password",
      title: "Television Character",
      active: true,
    )
  end

  # users create tests !!!comment out "before do" action above
  # and other test before running this test!!!

  # describe "POST /users" do
  #   it "should create a new user and return a hash/object of the created users info, status 200" do
  #     post "/api/users",
  #       params: {
  #         first_name: "Eddy",
  #         last_name: "Munster",
  #         email: "eddymunster@email.com",
  #         password: "password",
  #       }
  #     new_user = JSON.parse(response.body)
  #     expect(response).to have_http_status(200)
  #     expect(new_user["first_name"]).to eq("Eddy")
  #     expect(new_user["email"]).to eq("eddymunster@email.com")
  #   end
  #   it "no params should return an error status code of unprocessable_entity, 422" do
  #     post "/api/users", params: {}
  #     new_user = JSON.parse(response.body)
  #     expect(response).to have_http_status(422)
  #   end
  # end

  # users index tests

  describe "GET /users" do
    it "returns and array of users" do
      jwt = JWT.encode({ user_id: User.first.id }, Rails.application.credentials.fetch(:secret_key_base), "HS256")
      get "/api/users",
        headers: { "Authorization" => "Bearer #{jwt}" }
      users = JSON.parse(response.body)
      expect(response).to have_http_status(200)
      expect(users[0]["first_name"]).to eq("Eddy")
      expect(users[0]["title"]).to eq("Television Character")
      expect(users[0]["active"]).to eq(true)
    end
  end

  # # user show tests

  describe "GET /users/:id" do
    it "returns a hash/object of information for a single user" do
      jwt = JWT.encode({ user_id: User.first.id }, Rails.application.credentials.fetch(:secret_key_base), "HS256")
      get "/api/users/#{User.first.id}",
        headers: { "Authorization" => "Bearer #{jwt}" }
      single_user = JSON.parse(response.body)
      expect(response).to have_http_status(200)
      expect(single_user["first_name"]).to eq("Eddy")
      expect(single_user["email"]).to eq("eddymunster@email.com")
    end
    it "no jwt/authorization should return an error status code of unauthorized, 401" do
      get "/api/users/#{User.first.id}"
      single_user = JSON.parse(response.body)
      expect(response).to have_http_status(401)
    end
  end

  # users update tests

  describe "PATCH /users/:id" do
    it "should update a user" do
      jwt = JWT.encode({ user_id: User.first.id }, Rails.application.credentials.fetch(:secret_key_base), "HS256")
      patch "/api/users/#{User.first.id}",
        params: { first_name: "New Name", email: "newemail@email.com" },
        headers: { "Authorization" => "Bearer #{jwt}" }
      updated = JSON.parse(response.body)
      expect(response).to have_http_status(200)
      expect(updated["first_name"]).to eq("New Name")
      expect(updated["email"]).to eq("newemail@email.com")
    end
  end
end
