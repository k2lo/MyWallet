class Category < ApplicationRecord
    validates :name, presence: true, length: { minimum: 3, maximum: 25 }
    validates :user_id, presence: true
    validates_uniqueness_of :name, scope: :user_id
    has_many :expenses, dependent: :destroy
    belongs_to :user

    def expense_sum(current_user)
    	currency = Setting.find_by(user_id: current_user.id).currency
    	case currency
		when ISO4217::Currency.from_code('USD').symbol || nil
			self.expenses.sum(&:value)
		when ISO4217::Currency.from_code('EUR').symbol
			self.expenses.sum(&:value) / (ISO4217::Currency.from_code('EUR').exchange_rate)
		when ISO4217::Currency.from_code('PLN').symbol
		  self.expenses.sum(&:value) / (ISO4217::Currency.from_code('PLN').exchange_rate)
		end
    end

    def percentage(current_user)
    	self.expenses.sum(&:value) / Expense.all.sum_all(current_user) * 100.0
    end

    def self.basic_categories?
      Category.where(:name => ["Bills", "Clothes", "Food", "House"]).size != 4
    end
end