class Setting < ApplicationRecord
    validates :budget, numericality: { greater_than: 0 }
    belongs_to :user
end
