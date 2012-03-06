require 'json'

# Config. We override what was written to the amon.conf file based on the config that now lives
# in our cookbook.

if File.exists?('/etc/amon.conf')
  # We'll retain the config secret_key
  if node[:amon][:config][:secret_key].nil? || node[:amon][:config][:secret_key].empty?
    node[:amon][:config][:secret_key] = JSON.parse(File.read('/etc/amon.conf'))["secret_key"] # keys are strings, not symbols
    log "Retaining amon config secret_key from node configs (key saved in /etc/amon.conf)"
  else
    log "Retaining amon config secret_key from cookbook configs (key saved in node[:amon][:config][:secret_key])"
  end
end

config_json = node[:amon][:config].to_hash.to_json.to_s

# Write the new config file
file "/etc/amon.conf" do
    content "#{config_json}\n"
    owner "root"
    group "root"
end
