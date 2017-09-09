class Setting < ApplicationRecord
    validates :budget, numericality: { greater_than: 0 }
    belongs_to :user
    
    before_save do
        if self.currency == ISO4217::Currency.from_code('USD').symbol
            self.budget = self.budget
        elsif self.currency == ISO4217::Currency.from_code('EUR').symbol
            self.budget = self.budget*(ISO4217::Currency.from_code('EUR').exchange_rate)
        elsif self.currency == ISO4217::Currency.from_code('PLN').symbol
            self.budget = self.budget*(ISO4217::Currency.from_code('PLN').exchange_rate)
        end
    end
end
