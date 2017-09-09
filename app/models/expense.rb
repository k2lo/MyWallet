class Expense < ApplicationRecord
    validates :value, presence: true, numericality: { greater_than: 0 }
    validates :category_id, presence: true
    belongs_to :category
    belongs_to :user
    
    before_save do
        if @setting = Setting.order("created_at").last == nil  
            @setting = Setting.new(:budget => 0, :currency => ISO4217::Currency.from_code('USD').symbol)
        else
            @setting = Setting.order("created_at").last
        end
        
        if @setting.currency == ISO4217::Currency.from_code('USD').symbol
            self.value = self.value
        elsif @setting.currency == ISO4217::Currency.from_code('EUR').symbol
            self.value = self.value*(ISO4217::Currency.from_code('EUR').exchange_rate)
        elsif @setting.currency == ISO4217::Currency.from_code('PLN').symbol
            self.value = self.value*(ISO4217::Currency.from_code('PLN').exchange_rate)
        end
    end
end

