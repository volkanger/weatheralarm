json.array!(@users) do |user|
  json.extract! user, :id, :username, :email, :first_name, :last_name, :zipcode
  json.url user_url(user, format: :json)
end
