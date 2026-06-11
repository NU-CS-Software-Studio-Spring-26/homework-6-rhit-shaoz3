require "application_system_test_case"

class TodosTest < ApplicationSystemTestCase
  setup do
    @todo = todos(:one)
  end

  test "visiting the index" do
    visit todos_url
    assert_selector "h1", text: "Todos"
  end

  test "should create todo" do
    visit todos_url
    click_on "New todo"

    fill_in "Description", with: @todo.description
    select @todo.category, from: "Category"
    click_on "Create Todo"

    assert_text "Todo was successfully created"
    click_on "Back"
  end

  test "should update Todo" do
    visit todo_url(@todo)
    click_on "Edit this todo", match: :first

    fill_in "Description", with: @todo.description
    select @todo.category, from: "Category"
    click_on "Update Todo"

    assert_text "Todo was successfully updated"
    click_on "Back"
  end

  test "should update todo category" do
    @todo.update!(category: "work")
    visit edit_todo_url(@todo)

    select "study", from: "Category"
    click_on "Update Todo"

    assert_text "Todo was successfully updated"
    assert_text "Category:"
    assert_text "study"
    assert_equal "study", @todo.reload.category
  end

  test "should destroy Todo" do
    visit todo_url(@todo)
    click_on "Destroy this todo", match: :first

    assert_text "Todo was successfully destroyed"
  end
end
