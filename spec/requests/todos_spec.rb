require "rails_helper"

RSpec.describe "Todos", type: :request do
  describe "GET /todos" do
    it "returns success" do
      get todos_path

      expect(response).to have_http_status(:ok)
    end

    it "filters todos by category param" do
      Todo.create!(description: "Work task", category: "work")
      Todo.create!(description: "Study task", category: "study")

      get todos_path, params: { category: "work" }

      expect(response).to have_http_status(:ok)
      expect(response.body).to include("Work task")
      expect(response.body).not_to include("Study task")
    end
  end

  describe "GET /todos/:id" do
    it "shows a todo" do
      todo = Todo.create!(description: "Show me", category: "personal")

      get todo_path(todo)

      expect(response).to have_http_status(:ok)
      expect(response.body).to include("Show me")
    end
  end

  describe "POST /todos" do
    it "creates a todo" do
      post todos_path, params: { todo: { description: "New task", category: "work" } }

      expect(response).to redirect_to(todo_path(Todo.last))
      expect(Todo.last.description).to eq("New task")
    end
  end

  describe "PATCH /todos/:id" do
    it "updates a todo" do
      todo = Todo.create!(description: "Old task", category: "work")

      patch todo_path(todo), params: { todo: { description: "Updated task", category: "study" } }

      expect(response).to redirect_to(todo_path(todo))
      expect(todo.reload.description).to eq("Updated task")
      expect(todo.category).to eq("study")
    end
  end

  describe "DELETE /todos/:id" do
    it "destroys a todo" do
      todo = Todo.create!(description: "Delete me", category: "personal")

      expect {
        delete todo_path(todo)
      }.to change(Todo, :count).by(-1)

      expect(response).to redirect_to(todos_path)
    end
  end

  describe "GET /hello" do
    it "returns hello page" do
      get "/hello"

      expect(response).to have_http_status(:ok)
      expect(response.body).to include("Hello!")
    end
  end
end
