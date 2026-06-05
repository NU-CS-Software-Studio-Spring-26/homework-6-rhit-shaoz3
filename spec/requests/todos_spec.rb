require "rails_helper"

RSpec.describe "Todos index filtering", type: :request do
  it "filters todos by category param" do
    Todo.create!(description: "Work task", category: "work")
    Todo.create!(description: "Study task", category: "study")

    get todos_path, params: { category: "work" }

    expect(response).to have_http_status(:ok)
    expect(response.body).to include("Work task")
    expect(response.body).not_to include("Study task")
  end
end
