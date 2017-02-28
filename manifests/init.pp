# == Class: powerdns
class powerdns (
    $version                 = '4.0',
    $server                  = true,
    $server_config           = {},
    $server_backends         = [],
    $server_ensure           = $powerdns::params::server_ensure,
    $server_service_ensure   = $powerdns::params::server_service_ensure,
    $server_service_enable   = $powerdns::params::server_service_enable,
    $server_package_name     = $powerdns::params::server_package_name,

    $recursor                = false,
    $recursor_config         = {},
    $recursor_ensure         = $powerdns::params::recursor_ensure,
    $recursor_service_ensure = $powerdns::params::recursor_service_ensure,
    $recursor_service_enable = $powerdns::params::recursor_service_enable,
    $recursor_package_name   = $powerdns::params::recursor_package_name,

    $docker                  = false,

    ) inherits powerdns::params
{
    validate_string($version)
    validate_bool($server)
    if $server {
      validate_string($server_ensure)
      validate_array($server_backends)
    }

    anchor { 'powerdns::begin':} -> class { 'powerdns::install': }

    if $server {
      class { 'powerdns::server::install': }
      -> class { 'powerdns::server::config': }
      ~> class { 'powerdns::server::service': }

      Class['powerdns::install'] -> Class['powerdns::server::install']
      Class['powerdns::server::service'] -> Anchor['powerdns::end']
    }

    if $recursor {
      class { 'powerdns::recursor::install': }
      -> class { 'powerdns::recursor::config': }
      ~> class { 'powerdns::recursor::service': }

      Class['powerdns::install'] -> Class['powerdns::recursor::install']
      Class['powerdns::recursor::service'] -> Anchor['powerdns::end']
    }

    if $docker {
      file {'/entrypoint.sh':
        ensure  => file,
        content => template('entrypoint.sh.erb'),
        mode    => '0755',
        owner   => root,
        group   => root,
      }
    }

    anchor { 'powerdns::end':}
}
