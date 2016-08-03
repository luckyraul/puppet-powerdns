# == Class: powerdns::install
class powerdns::install (
    $ensure = present,
    $version = $powerdns::version
  ) {

    include apt
    if $version != '3.0' {
      apt::key { 'powerdns':
        ensure => $ensure,
        id     => $powerdns::params::apt_key_id,
        source => $powerdns::params::apt_key_source,
      }

      apt::pin { 'powerdns':
        ensure   => $ensure,
        origin   => 'repo.powerdns.com',
        packages => 'pdns-*',
        priority => 600,
      }
    }
}
