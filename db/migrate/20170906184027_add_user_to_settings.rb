class AddUserToSettings < ActiveRecord::Migration[5.0]
  def change
    add_reference :settings, :user, foreign_key: true
  end
end
