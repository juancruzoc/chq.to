json.extract! short_link, :id, :user_id, :short_url, :url, :expiration_date, :password, :usages, :created_at, :updated_at
json.url short_link_url(short_link, format: :json)
