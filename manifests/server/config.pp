# == Class: powerdns::server::config
class powerdns::server::config (
    $config = $powerdns::server_config,
    $path   = $powerdns::params::server_config_path,
  )
{
  $result = deep_merge($powerdns::params::server_config_default, { '' => $config})
  $defaults = { 'path' => $path }
  inifile::create_ini_settings($result, $defaults)
}
