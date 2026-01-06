json.extract! dry_food, :id, :brand, :food_type, :description, :amount, :used_amount, :average_used_amount, :total_ate_amount, :left_amount, :days_remaining, :user_id, :created_at, :updated_at
json.url dry_food_url(dry_food, format: :json)
