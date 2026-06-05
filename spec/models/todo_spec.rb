require "rails_helper"

RSpec.describe Todo, type: :model do
  it "requires a valid category" do
    todo = Todo.new(description: "Invalid category task", category: "invalid")

    expect(todo).not_to be_valid
    expect(todo.errors[:category]).to be_present
  end

  describe ".with_category" do
    it "returns only todos in the selected category" do
      work_todo = Todo.create!(description: "Work task", category: "work")
      Todo.create!(description: "Study task", category: "study")

      results = Todo.with_category("work")

      expect(results).to contain_exactly(work_todo)
    end
  end
end
