class Setting < ApplicationRecord
    validates :budget, numericality: { greater_than_or_equal_to: 0 }
    belongs_to :user
    
    before_save :set_budget 

    def set_budget
      case self.currency
        when 'EUR' || nil
            self.budget
        when 'USD'
            self.budget = self.budget * Money.default_bank.get_rate('EUR', 'USD')
        when 'PLN'
        	self.budget = self.budget * Money.default_bank.get_rate('EUR', 'PLN')
        end
        self.budget.to_f.round(2)
    end
end
