# == Class: telegraf::params
#
# A set of default parameters for Telegraf's configuration.
#
class telegraf::params {
  $config_dir = $::osfamily ? {
    'windows' => 'C:/Program Files/telegraf',
    'FreeBSD' => '/usr/local/etc/telegraf',
    default   => '/etc/telegraf',
  }

  if $::osfamily == 'windows' {
    $config_file_owner    = 'Administrator'
    $config_file_group    = 'Administrators'
    $logfile              = "$config_dir/telegraf.log"
    $manage_repo          = false
    $service_enable       = true
    $service_ensure       = running
    $service_hasstatus    = false
    $service_restart      = undef
  } else {
    $config_file_owner    = 'telegraf'
    $config_file_group    = 'telegraf'
    $logfile              = ''
    $manage_repo          = true
    $service_enable       = true
    $service_ensure       = running
    $service_hasstatus    = true
    $service_restart      = 'pkill -HUP telegraf'
  }
  $config_file          = "$config_dir/telegraf.conf"
  $config_folder        = "$config_dir/telegraf.d"
  $package_name           = 'telegraf'
  $ensure                 = 'present'
  $install_options        = []
  $hostname               = $::hostname
  $omit_hostname          = false
  $interval               = '10s'
  $round_interval         = true
  $metric_batch_size      = '1000'
  $metric_buffer_limit    = '10000'
  $collection_jitter      = '0s'
  $flush_interval         = '10s'
  $flush_jitter           = '0s'
  $debug                  = false
  $quiet                  = false
  $global_tags            = {}
  $manage_service         = true
  $purge_config_fragments = false
  $repo_type              = 'stable'
  $windows_package_url    = 'https://chocolatey.org/api/v2/'

  $outputs = {
    'influxdb'  => {
      'urls'     => [ 'http://localhost:8086' ],
      'database' => 'telegraf',
      'username' => 'telegraf',
      'password' => 'metricsmetricsmetrics',
    }
  }

  $inputs = {
    'cpu'  => {
      'percpu'   => true,
      'totalcpu' => true,
    }
  }
}
