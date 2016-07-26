# == Class: powerdns::params
class powerdns::params {
    $ensure = present
    $server_ensure = 'latest'
    $server_service_ensure = 'running'
    $server_service_enable = true
    $server_config_path = '/etc/powerdns/pdns.conf'
    $server_config_default = {
      '' => {
        'allow-recursion' => '127.0.0.1',
        'config-dir' => '/etc/powerdns',
        'guardian' => 'yes',
        'local-address' => $::ipaddress,
        'master' => 'yes',
        'slave' => 'no',
      }
    }


    $recursor_ensure = 'latest'
    $recursor_service_ensure = 'running'
    $recursor_service_enable = true
    $recursor_config_path = '/etc/powerdns/recursor.conf'
    $recursor_config_default = {
      '' => {
        'allow-from' => '127.0.0.1',
        'local-address' => '127.0.0.1',
      }
    }

    $apt_key_source = 'https://repo.powerdns.com/FD380FBB-pub.asc'
    $apt_key_id     = '9FAAA5577E8FCF62093D036C1B0C6205FD380FBB'
    $apt_location = 'http://repo.powerdns.com/debian'

    case $::operatingsystem {
        'Debian': {
            case $::lsbdistcodename {
                'jessie': {
                    $server_package_name = 'pdns-server'
                    $server_apt_repo = 'jessie-auth-40'

                    $recursor_package_name = 'pdns-recursor'
                    $recursor_apt_repo = 'jessie-rec-40'
                }
                default: {
                    fail("Unsupported release: ${::lsbdistcodename}")
                }
            }
        }
        default: {
            fail("Unsupported os: ${::operatingsystem}")
        }
    }
}
