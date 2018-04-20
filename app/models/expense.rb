class Expense < ApplicationRecord
    validates :value, presence: true, numericality: { greater_than: 0 }
    validates :category_id, presence: true
    belongs_to :category
    belongs_to :user
    
    before_save :set_currency 

    def set_currency
      currency = Setting.find_by(user_id: self.user.id).currency
      case currency
    	when 'EUR'
    		self.value
    	when 'USD'
    		self.value = self.value * Money.default_bank.get_rate('EUR', 'USD')
    	when 'PLN'
    	  self.value = self.value * Money.default_bank.get_rate('EUR', 'PLN')
    	end
      self.value.to_f.round(2)
    end

    def expense_val
      currency = Setting.find_by(user_id: self.user.id).currency
      case currency
      when 'EUR'
        self.value
      when 'USD'
        self.value / Money.default_bank.get_rate('EUR', 'USD')
      when 'PLN'
        self.value /  Money.default_bank.get_rate('EUR', 'PLN')
      end
      self.value.to_f.round(2)
    end

    def self.sum_all(current_user)
    	self.where(user_id: current_user.id).sum(&:value)
    end


end

