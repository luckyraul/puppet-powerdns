# == Class: powerdns::recursor::config
class powerdns::recursor::config (
    $config = $powerdns::recursor_config,
    $path   = $powerdns::params::recursor_config_path,
  )
{
  $result = deep_merge($powerdns::params::recursor_config_default, { '' => $config})
  $defaults = { 'path' => $path }
  inifile::create_ini_settings($result, $defaults)
}
