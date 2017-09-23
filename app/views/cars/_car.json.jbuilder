json.extract! car, :id, :title, :description, :image_url, :price, :created_at, :updated_at
json.url car_url(car, format: :json)
