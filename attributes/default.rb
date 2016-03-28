default['dispatcher']['renderer']['port'] = "4503"
default['dispatcher']['renderer']['hostname'] = "localhost"
default['dispatcher']['landing_page'] = "/content"

default['dispatcher']['config_file_path'] = "dispatcher.any"
default['dispatcher']['log_level'] = "1"
default['dispatcher']['installation_dir'] = "/data/dispatcher"    
default[:aem][:dispatcher][:installation_dir] = "/data/dispatcher"      
default[:aem][:dispatcher][:landing_page] = "/content"
default[:aem][:dispatcher][:conf_file] = 'dispatcher.any'
default[:aem][:dispatcher][:log_file] = 'logs/dispatcher.log'
default[:aem][:dispatcher][:log_level] = '1'
default[:aem][:dispatcher][:no_server_header] = '0'
default[:aem][:dispatcher][:decline_root] = '0'
default[:aem][:dispatcher][:use_processed_url] = '0'
default[:aem][:dispatcher][:pass_error] = '0'