# == Class: powerdns::server::install
class powerdns::server::install (
    $ensure       = $powerdns::server_ensure,
    $backends     =  $powerdns::server_backends,
    $package_name = $powerdns::server_package_name,
    $location     = $powerdns::params::apt_location,
    $repo         = $powerdns::params::server_apt_repo,
  )
{
    apt::source { 'powerdns-server':
        location => $location,
        release  => $repo,
        repos    => 'main',
        include  => {
            src => false
        },
    } ->

    package { 'powerdns-server':
        ensure => $ensure,
        name   => $package_name
    }
    ->
    package { $backends:
        ensure => $ensure,
    }

    Exec['apt_update'] -> Package['powerdns-server']
}
