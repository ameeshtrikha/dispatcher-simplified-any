default['dispatcher']['renderer']['port'] = "4503"
default['dispatcher']['renderer']['hostname'] = "localhost"
default['dispatcher']['landing_page'] = "/content"

default['dispatcher']['config_file_path'] = "dispatcher.any"
default['dispatcher']['log_level'] = "1"
default['dispatcher']['installation_dir'] = "/data/dispatcher"    
default[:aem][:dispatcher][:installation_dir] = "/data/dispatcher"      
default[:aem][:dispatcher][:landing_page] = "/content"