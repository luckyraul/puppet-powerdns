# == Class: powerdns::recursor::service
class powerdns::recursor::service (
  $service_ensure   = $powerdns::recursor_service_ensure,
  $service_enable   = $powerdns::recursor_service_enable,
)
{
  service {'pdns-recursor':
      ensure => $service_ensure,
      enable => $service_enable,
  }
}
