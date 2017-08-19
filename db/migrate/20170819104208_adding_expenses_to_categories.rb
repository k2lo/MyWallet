class AddingExpensesToCategories < ActiveRecord::Migration[5.0]
  def change
     add_column :categories, :totalexpenses, :integer
  end
end
