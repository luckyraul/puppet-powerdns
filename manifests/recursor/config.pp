# == Class: powerdns::recursor::config
class powerdns::recursor::config (
    $config = $powerdns::recursor_config,
    $path   = $powerdns::params::recursor_config_path,
  )
{
  $result = deep_merge({ '' => $config}, $powerdns::params::recursor_config_default)
  $defaults = { 'path' => $path }
  create_ini_settings($result, $defaults)
}
