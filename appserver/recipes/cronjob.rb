# Delete existing cron entries
%w[cron_hourly cron_everyminute].each do |cron_id|
  cron cron_id do
    action :delete
  end
end

# Create / update cron entries
cron "cron_hourly" do
  hour "*"
  minute "0"
  action :create
  command "echo Hourly > /tmp/cron.hourly.txt"
end

cron "cron_everyminute" do
  hour "*"
  minute "*"
  action :create
  command "echo Minute > /tmp/cron.minute.txt"
end