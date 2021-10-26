# == Class: powerdns::params
class powerdns::params {
    $ensure = present
    $server_ensure = 'latest'
    $server_service_ensure = 'running'
    $server_service_enable = true
    $config_dir = '/etc/powerdns'
    $server_user = 'pdns'

    $data_dir = '/var/lib/powerdns'
    $include_dir = "${config_dir}/pdns.d"
    $server_config_path = "${config_dir}/pdns.conf"
    $server_config_default = {
      '' => {
        'config-dir' => '/etc/powerdns',
        'daemon' => 'yes',
        'guardian' => 'yes',
        'local-address' => $::ipaddress,
        'master' => 'yes',
        'slave' => 'no',
        'query-cache-ttl' => 20,
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
                'bullseye': {
                    $server_package_name = 'pdns-server'
                    $server_apt_repo = 'bullseye-auth-45'

                    $recursor_package_name = 'pdns-recursor'
                    $recursor_apt_repo = 'bullseye-rec-45'
                }
                'buster': {
                    $server_package_name = 'pdns-server'
                    $server_apt_repo = 'buster-auth-42'

                    $recursor_package_name = 'pdns-recursor'
                    $recursor_apt_repo = 'buster-rec-42'
                }
                'stretch': {
                    $server_package_name = 'pdns-server'
                    $server_apt_repo = 'stretch-auth-42'

                    $recursor_package_name = 'pdns-recursor'
                    $recursor_apt_repo = 'stretch-rec-42'
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
