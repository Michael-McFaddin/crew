require "rails_helper"

RSpec.describe "Calendars", type: :request do

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
    calendar = Calendar.create(
      user_id: user.id,
      avail: "available",
      start_date: "2021-05-02",
      end_date: "2021-05-17",
    )
  end

  # calendars create test

  describe "POST /calendars" do
    it "should create a calendar entry for a user" do
      jwt = JWT.encode({ user_id: User.first.id }, Rails.application.credentials.fetch(:secret_key_base), "HS256")
      post "/api/calendars",
        params: {
          avail: "unavailable",
          start_date: "2022-02-22",
          end_date: "2022-03-12",
        },
        headers: { "Authorization" => "Bearer #{jwt}" }
      calendar = JSON.parse(response.body)
      expect(response).to have_http_status(200)
      expect(calendar["user_id"]).to eq(User.first.id)
      expect(calendar["start_date"]).to eq("2022-02-22")
      expect(calendar["end_date"]).to eq("2022-03-12")
    end
  end

  # calendars show tests

  describe "GET /calendars/:id" do
    it "returns a hash/object of information for a single user" do
      jwt = JWT.encode({ user_id: User.first.id }, Rails.application.credentials.fetch(:secret_key_base), "HS256")
      get "/api/calendars/#{Calendar.first.id}",
        headers: { "Authorization" => "Bearer #{jwt}" }
      calendar = JSON.parse(response.body)
      expect(response).to have_http_status(200)
      expect(calendar["user_id"]).to eq(User.first.id)
      expect(calendar["availability"]).to eq("available")
      expect(calendar["end_date"]).to eq("2021-05-17")
    end
    it "no jwt/authorization should return an error status code of unauthorized, 401" do
      get "/api/calendars/#{Calendar.first.id}"
      calendar = JSON.parse(response.body)
      expect(response).to have_http_status(401)
    end
  end

  # calendar update test

  describe "PATCH /calendars/:id" do
    it "should update a calendar" do
      jwt = JWT.encode({ user_id: User.first.id }, Rails.application.credentials.fetch(:secret_key_base), "HS256")
      patch "/api/calendars/#{Calendar.first.id}",
        params: { availability: "on hold", end_date: "2021-05-25" },
        headers: { "Authorization" => "Bearer #{jwt}" }
      updated = JSON.parse(response.body)
      expect(response).to have_http_status(200)
      expect(updated["availability"]).to eq("on hold")
      expect(updated["end_date"]).to eq("2021-05-25")
    end
  end

  # calendar delete test

  describe "DELETE /calendars/:id" do
    it "should delete an user_category and return a message and id" do
      jwt = JWT.encode({ user_id: User.first.id }, Rails.application.credentials.fetch(:secret_key_base), "HS256")
      delete "/api/calendars/#{Calendar.first.id}",
        headers: { "Authorization" => "Bearer #{jwt}" }
      deleted_calendar = JSON.parse(response.body)
      expect(response).to have_http_status(200)
      expect(deleted_calendar["message"]).to eq("Calendar entry deleted")
      # expect(deleted_calendar["id"]).to eq(Calendar.first.id)
    end
  end
end
