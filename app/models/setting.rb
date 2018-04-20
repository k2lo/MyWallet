class Setting < ApplicationRecord
    validates :budget, numericality: { greater_than_or_equal_to: 0 }
    belongs_to :user

end
