json.extract! expense, :id, :value, :description, :created_at, :updated_at
json.url expense_url(expense, format: :json)
