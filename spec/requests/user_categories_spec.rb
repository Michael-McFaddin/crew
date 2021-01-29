require "rails_helper"

RSpec.describe "UserCategories", type: :request do

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
  end

  # describe "GET /user_categories" do
  #   it "works! (now write some real specs)" do
  #     get user_categories_index_path
  #     expect(response).to have_http_status(200)
  #   end
  # end
end
