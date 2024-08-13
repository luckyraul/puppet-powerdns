# == Class: powerdns::install
class powerdns::config ($files) {
  create_resources(powerdns::resource::config, $files)
}
