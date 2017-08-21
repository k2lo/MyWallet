class Expense < ApplicationRecord
    validates :value, presence: true
    validates :category_id, presence: true
    belongs_to :category
end
