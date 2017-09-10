class Category < ApplicationRecord
    validates :name, presence: true, length: { minimum: 3, maximum: 25 }
    validates :user_id, presence: true
    validates_uniqueness_of :name, scope: :user_id
    has_many :expenses, dependent: :destroy
    belongs_to :user


end
