# == Define: telegraf::input
#
# A Puppet wrapper for discrete Telegraf input files
#
# === Parameters
#
# [*options*]
#   List. Plugin options for use in the input template.
#
# [*plugin_type*]
#   String. Define the telegraf plugin type to use (default is $name)
#
# [*ensure*]
#   Set if the ensure params of the config file. If telegraf::ensure is absent the value is automatically absent
#
define telegraf::input (
  String $plugin_type               = $name,
  Array  $options                   = [],
  Enum['present', 'absent'] $ensure = 'present',
) {
  include telegraf

  $_ensure = $telegraf::ensure ? {
    'absent' => 'absent',
    default  => $ensure,
  }

  file { "${telegraf::config_folder}/${name}.conf":
    ensure  => $_ensure,
    content => inline_template("<%= require 'toml-rb'; TomlRB.dump({'inputs.${plugin_type}' => @options}) %>"),
    require => Class['telegraf::config'],
    notify  => Class['telegraf::service'],
  }
}
