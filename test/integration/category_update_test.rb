require "test_helper"

class CategoryUpdateTest < ActionDispatch::IntegrationTest
  test "update changes category when category param is sent" do
    todo = todos(:one)
    assert_equal "work", todo.category

    patch todo_url(todo), params: { todo: { description: todo.description, category: "study" } }
    assert_redirected_to todo_url(todo)

    todo.reload
    assert_equal "study", todo.category
  end

  test "update fails when category param is omitted" do
    todo = todos(:one)
    assert_equal "work", todo.category

    patch todo_url(todo), params: { todo: { description: "updated description" } }
    assert_response :unprocessable_content

    todo.reload
    assert_equal "work", todo.category
    assert_equal "MyString", todo.description
  end

  test "update with blank category fails and does not change category" do
    todo = todos(:one)

    patch todo_url(todo), params: { todo: { description: todo.description, category: "" } }
    assert_response :unprocessable_content

    todo.reload
    assert_equal "work", todo.category
  end

  test "edit form includes category field with current value selected" do
    todo = todos(:one)
    get edit_todo_url(todo)

    assert_select "form[action=?]", todo_path(todo)
    assert_select "select[name=?]", "todo[category]" do
      assert_select "option[selected][value=?]", "work"
    end
    assert_select "select[name=?]", "category", count: 0
  end

  test "patching via edit form html fields updates category" do
    todo = todos(:one)
    get edit_todo_url(todo)

    patch todo_url(todo), params: {
      todo: {
        description: "changed via form",
        category: "home chores"
      }
    }

    todo.reload
    assert_equal "home chores", todo.category
    assert_equal "changed via form", todo.description
  end
end
