class Todo < ApplicationRecord
  CATEGORIES = [ "work", "study", "home chores", "personal" ].freeze

  scope :with_category, ->(category) { where(category: category) }

  validates :category, presence: true, inclusion: { in: CATEGORIES }
end
