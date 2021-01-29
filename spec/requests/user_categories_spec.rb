require "rails_helper"

RSpec.describe "UserCategories", type: :request do

  # before action creation of user, categories, user_category

  before do
    user = User.create(
      first_name: "Eddy",
      last_name: "Munster",
      email: "eddymunster@email.com",
      password: "password",
      title: "Television Character",
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
    user_category = UserCategory.create([
      {
        user_id: user.id,
        category_id: categories[0].id,
      },
    ])
  end

  # user_categories create test

  describe "POST /user_categories" do
    it "should create an association to user and category" do
      jwt = JWT.encode({ user_id: User.first.id }, Rails.application.credentials.fetch(:secret_key_base), "HS256")
      post "/api/user_categories",
        params: {
          user_id: User.first.id,
          category_id: Category.first.id,
        },
        headers: { "Authorization" => "Bearer #{jwt}" }
      user_category = JSON.parse(response.body)
      expect(response).to have_http_status(200)
      expect(user_category["user_id"]).to eq(User.first.id)
      expect(user_category["category_id"]).to eq(Category.first.id)
    end
  end

  # user_categories destroy test

  describe "DELETE /user_categories/:id" do
    it "should delete an user_category and return a message and id" do
      jwt = JWT.encode({ user_id: User.first.id }, Rails.application.credentials.fetch(:secret_key_base), "HS256")
      delete "/api/user_categories/#{UserCategory.first.id}",
        headers: { "Authorization" => "Bearer #{jwt}" }
      deleted_user_category = JSON.parse(response.body)
      expect(response).to have_http_status(200)
      expect(deleted_user_category["message"]).to eq("User Category destroyed")
    end
  end
end
