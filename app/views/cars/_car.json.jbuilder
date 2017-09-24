json.extract! car, :id, :title, :description, :image_url, :price, :created_at, :updated_at, :status, :license_plate, :model, :manufactor, :style, :location
json.url car_url(car, format: :json)
