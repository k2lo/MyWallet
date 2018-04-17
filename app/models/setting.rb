class Setting < ApplicationRecord
    validates :budget, numericality: { greater_than_or_equal_to: 0 }
    belongs_to :user
    
    before_save :set_budget 

    def set_budget
      case self.currency
        when ISO4217::Currency.from_code('USD').symbol || nil
            self.budget = self.budget
        when ISO4217::Currency.from_code('EUR').symbol
            self.budget = self.budget*(ISO4217::Currency.from_code('EUR').exchange_rate)
        when ISO4217::Currency.from_code('PLN').symbol
        	self.budget = self.budget*(ISO4217::Currency.from_code('PLN').exchange_rate)
        end
    end
end
