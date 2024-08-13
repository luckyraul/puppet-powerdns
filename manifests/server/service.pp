# == Class: powerdns::server::service
class powerdns::server::service (
  $service_ensure   = $powerdns::server_service_ensure,
  $service_enable   = $powerdns::server_service_enable,
) {
  service { 'pdns':
    ensure => $service_ensure,
    enable => $service_enable,
  }
}
