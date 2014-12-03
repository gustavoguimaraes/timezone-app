root_url = 'http://localhost:3000'

email = "#{SecureRandom.hex}@example.com"
password = "password"

# Create a new user
uri = URI("#{root_url}/api/v1/users")
params = {"user[email]" => email, "user[password]" => password}
res = Net::HTTP.post_form(uri, params)
token = JSON.parse(res.body)["token"]

# Get authentication token
uri = URI("#{root_url}/api/v1/sessions")
params = {"user[email]" => email, "user[password]" => password}
res = Net::HTTP.post_form(uri, params)
token = JSON.parse(res.body)["token"]

# List all zones
uri = URI("#{root_url}/api/v1/zones")
http = Net::HTTP.new(uri.host, uri.port)
req = Net::HTTP::Get.new(uri.path)
req["AUTHORIZATION"] = token
res = http.request(req)
pp JSON.parse(res.body) if res.is_a?(Net::HTTPSuccess)

# Create a new zone
uri = URI("#{root_url}/api/v1/zones")
http = Net::HTTP.new(uri.host, uri.port)
req = Net::HTTP::Post.new(uri.path)
req["AUTHORIZATION"] = token
params = {"zone[name]" => "Name", "zone[city_name]" => "City", "zone[minutes_offset]" => 60}
req.set_form_data(params)
res = http.request(req)
puts res.body if res.is_a?(Net::HTTPSuccess)
index = JSON.parse(res.body)["zone"]["id"]

# Update a zone
uri = URI("#{root_url}/api/v1/zones/#{index}")
http = Net::HTTP.new(uri.host, uri.port)
req = Net::HTTP::Patch.new(uri.path)
req["AUTHORIZATION"] = token
params = {"zone[name]" => "New Name 2 ", "zone[city_name]" => "New City 2", "zone[minutes_offset]" => 120}
req.set_form_data(params)
res = http.request(req)

# Delete a zone
uri = URI("#{root_url}/api/v1/zones/#{index}")
http = Net::HTTP.new(uri.host, uri.port)
req = Net::HTTP::Delete.new(uri.path)
req["AUTHORIZATION"] = token
res = http.request(req)

