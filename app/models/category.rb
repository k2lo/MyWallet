class Category < ApplicationRecord
    validates :name, presence: true, length: { minimum: 3, maximum: 25 }
    validates :user_id, presence: true
    validates_uniqueness_of :name, scope: :user_id
    has_many :expenses, dependent: :destroy
    belongs_to :user

    def expense_sum(current_user)
    	currency = Setting.find_by(user_id: current_user.id).currency
    	case currency
		when 'EUR' || nil
		  sum = self.expenses.sum(&:value)
		when 'USD'
		  sum = self.expenses.sum(&:value) / Money.default_bank.get_rate('EUR', 'USD')
		when 'PLN'
		  sum = self.expenses.sum(&:value) / Money.default_bank.get_rate('EUR', 'PLN')
		end
        sum.to_f.round(2)
    end

    def percentage(current_user)
    	self.expenses.sum(&:value) / Expense.all.sum_all(current_user) * 100.0
    end

    def self.basic_categories?
      Category.where(:name => ["Bills", "Clothes", "Food", "House"]).size != 4
    end
end