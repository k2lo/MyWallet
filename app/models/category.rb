class Category < ApplicationRecord
    validates :name, presence: true, length: { minimum: 3, maximum: 25 }
    validates :user_id, presence: true
    validates_uniqueness_of :name, scope: :user_id
    has_many :expenses, dependent: :destroy
    belongs_to :user

    def expense_sum
		self.expenses.sum(&:value)
    end

    def percentage(current_user)
    	expense_sum / Expense.all.sum_all(current_user) * 100.0
    end

    def self.basic_categories?
      Category.where(:name => ["Bills", "Clothes", "Food", "House"]).size != 4
    end
end