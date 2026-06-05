Given("the following todos exist:") do |table|
  table.hashes.each do |row|
    Todo.create!(description: row["description"], category: row["category"])
  end
end

When("I filter todos by category {string}") do |category|
  visit todos_path
  select category, from: "Filter by category"
  click_button "Apply filter"
end

Then("I should see the todo {string}") do |description|
  expect(page).to have_content(description)
end

Then("I should not see the todo {string}") do |description|
  expect(page).not_to have_content(description)
end

Then("the todos list should be empty") do
  expect(page).to have_css("#todos")
  expect(page).to have_no_css('[id^="todo_"]')
end
