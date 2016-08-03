# == Class: powerdns::server::install
class powerdns::server::install (
    $version      = $powerdns::version,
    $ensure       = $powerdns::server_ensure,
    $backends     = $powerdns::server_backends,
    $package_name = $powerdns::server_package_name,
    $data_dir     = $powerdns::params::data_dir,
    $location     = $powerdns::params::apt_location,
    $repo         = $powerdns::params::server_apt_repo,
  )
{
    if $version != '3.0' {
      apt::source { 'powerdns-server':
          location => $location,
          release  => $repo,
          repos    => 'main',
          include  => {
              src => false
          },
      } -> Package['powerdns-server']
    }

    package { 'powerdns-server':
        ensure => $ensure,
        name   => $package_name
    } ->
    package { $backends:
        ensure => $ensure,
    } ->
    file { $data_dir:
      ensure => directory,
    } ->
    file { "${data_dir}/zones":
      ensure => directory,
    }

    Exec['apt_update'] -> Package['powerdns-server']
}
