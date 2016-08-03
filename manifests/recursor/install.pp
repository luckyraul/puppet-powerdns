# == Class: powerdns::server::install
class powerdns::recursor::install (
    $version      = $powerdns::version,
    $ensure       = $powerdns::recursor_ensure,
    $package_name = $powerdns::recursor_package_name,
    $location     = $powerdns::params::apt_location,
    $repo         = $powerdns::params::recursor_apt_repo,
  )
{
    if $version != '3.0' {
      apt::source { 'powerdns-recursor':
          location => $location,
          release  => $repo,
          repos    => 'main',
          include  => {
              src => false
          },
      } -> Package['powerdns-recursor']
    }

    package { 'powerdns-recursor':
        ensure => $ensure,
        name   => $package_name
    }

    Exec['apt_update'] -> Package['powerdns-recursor']
}
