json.extract! event, :id, :date, :miles, :hours, :minutes, :shoe, :created_at, :updated_at
json.url event_url(event, format: :json)
