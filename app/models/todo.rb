class Todo < ApplicationRecord
  CATEGORIES = [ "work", "study", "home chores", "personal" ].freeze

  validates :category, presence: true, inclusion: { in: CATEGORIES }
end
