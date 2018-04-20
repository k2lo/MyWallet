class Expense < ApplicationRecord
    validates :value, presence: true, numericality: { greater_than: 0 }
    validates :category_id, presence: true
    belongs_to :category
    belongs_to :user
    

    def self.sum_all(current_user)
    	self.where(user_id: current_user.id).sum(&:value)
    end


end

