# == Class: powerdns::server::config
class powerdns::server::config (
    $config = $powerdns::server_config,
    $path   = $powerdns::params::server_config_path,
  )
{
  $result = deep_merge({ '' => $config}, $powerdns::params::server_config_default)
  $defaults = { 'path' => $path }
  create_ini_settings($result, $defaults)
}
