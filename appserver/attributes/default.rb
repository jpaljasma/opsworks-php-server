default[:appserver] = {}

default[:appserver][:apc] = {}
default[:appserver][:apc][:enabled] = '1'
default[:appserver][:apc][:shm_size] = '256M'
default[:appserver][:apc][:gc_ttl] = '600'

default[:appserver][:geoip] = {}
default[:appserver][:geoip][:path] = '/usr/share/GeoIP/'
default[:appserver][:geoip][:country_dat_url] = 'http://geolite.maxmind.com/download/geoip/database/GeoLiteCountry/GeoIP.dat.gz'
default[:appserver][:geoip][:city_dat_url]    = 'http://geolite.maxmind.com/download/geoip/database/GeoLiteCity.dat.gz'

default[:appserver][:env] = 'production'
