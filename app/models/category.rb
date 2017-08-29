class Category < ApplicationRecord
    validates :name, presence: true, length: { minimum: 3, maximum: 25 }
    validates :user_id, presence: true
    validates_uniqueness_of :name
    has_many :expenses
    belongs_to :user
    
    
end
