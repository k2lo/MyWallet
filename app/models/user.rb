class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :categories
  has_many :expenses
  has_one :setting
  after_save :create_basic_settings
  
  def create_basic_settings
    setting = Setting.new(:budget => 0, :currency => ISO4217::Currency.from_code('USD').symbol, :user_id => self.id)
    setting.save
  end
end
