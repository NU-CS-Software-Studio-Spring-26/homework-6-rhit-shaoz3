Feature: Filter todos by category
  As a user
  I want to filter my todo list by category
  So that I can focus on related tasks

  Background:
    Given the following todos exist:
      | description    | category |
      | Finish report  | work     |
      | Read chapter 3 | study    |

  Scenario: User filters todos by an existing category
    When I filter todos by category "work"
    Then I should see the todo "Finish report"
    And I should not see the todo "Read chapter 3"

  Scenario: Category filter with no matches
    When I filter todos by category "home chores"
    Then the todos list should be empty
