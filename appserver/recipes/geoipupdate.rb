# download GeoIP Country DB
bash "download_geoip_db" do
  not_if do
    File.exists?("/usr/share/GeoIP/GeoIP.dat") &&
    File.mtime("/usr/share/GeoIP/GeoIP.dat") > Time.now - 2592000
  end
  user "root"
  code <<-EOH
    cd /tmp
    rm -f /tmp/GeoIP.dat.gz
    wget http://geolite.maxmind.com/download/geoip/database/GeoLiteCountry/GeoIP.dat.gz
    gunzip GeoIP.dat.gz
    sudo mv -f GeoIP.dat /usr/share/GeoIP/GeoIP.dat
  EOH
end

# download GeoIP City DB
bash "download_geolite_city_db" do
  not_if do
    File.exists?("/usr/share/GeoIP/GeoIPCity.dat") &&
    File.mtime("/usr/share/GeoIP/GeoIPCity.dat") > Time.now - 2592000
  end
  user "root"
  code <<-EOH
    cd /tmp
    rm -f /tmp/GeoLiteCity.dat.gz
    wget http://geolite.maxmind.com/download/geoip/database/GeoLiteCity.dat.gz
    gunzip GeoLiteCity.dat.gz
    sudo mv -f GeoLiteCity.dat /usr/share/GeoIP/GeoIPCity.dat
  EOH
end
