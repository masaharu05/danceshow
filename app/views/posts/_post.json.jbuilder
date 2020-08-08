json.extract! post, :id, :memo, :video, :genre, :music, :user_id, :created_at, :updated_at
json.url post_url(post, format: :json)
