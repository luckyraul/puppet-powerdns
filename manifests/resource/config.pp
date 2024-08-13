# == Define: powerdns::install
define powerdns::resource::config (
  $ensure      = 'present',
  $config_hash = {}
) {
  file { "${powerdns::params::include_dir}/${name}.conf":
    ensure  => $ensure,
    require => Package['powerdns-server'],
  }

  $defaults = {
    'path' => "${powerdns::params::include_dir}/${name}.conf",
    require => File["${powerdns::params::include_dir}/${name}.conf"],
  }
  create_ini_settings({ '' => $config_hash }, $defaults)
}
