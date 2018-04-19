class Expense < ApplicationRecord
    validates :value, presence: true, numericality: { greater_than: 0 }
    validates :category_id, presence: true
    belongs_to :category
    belongs_to :user
    
    before_save :set_currency 

    def set_currency
      currency = Setting.find_by(user_id: self.user.id).currency
      case currency
    	when ISO4217::Currency.from_code('USD').symbol
    		self.value
    	when ISO4217::Currency.from_code('EUR').symbol
    		self.value = self.value * (ISO4217::Currency.from_code('EUR').exchange_rate)
    	when ISO4217::Currency.from_code('PLN').symbol
    	  self.value = self.value * (ISO4217::Currency.from_code('PLN').exchange_rate)
    	end
    end

    def expense_val
      currency = Setting.find_by(user_id: self.user.id).currency
      case currency
      when ISO4217::Currency.from_code('USD').symbol
        self.value
      when ISO4217::Currency.from_code('EUR').symbol
        self.value / (ISO4217::Currency.from_code('EUR').exchange_rate)
      when ISO4217::Currency.from_code('PLN').symbol
        self.value / (ISO4217::Currency.from_code('PLN').exchange_rate)
      end
    end

    def self.sum_all(current_user)
    	self.where(user_id: current_user.id).sum(&:value)
    end


end

