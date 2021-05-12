#
# == Class: dockerapp_ccm
#
# Installs and configures tyk api management using docker 
#
# === Parameters
#
# [*service_name*]
#   The name of the docker service and folders to be created
#
# [*ports*]
#   Ports to be used by the app
#
# [*version*]
#   The version of the image
#
# [*host_name*]
#   Hostname of the server
#
# [*project_key*]
#   Change for random value
#
# [*env*]
#   Environment
#
# [*use_bundled_db*]
#   If it is to use the included mysql db
#
# [*db_name*]
#   database name
#
# [*db_user*]
#   database name
#
# [*db_pw*]
#   database password
#
# [*db_host*]
#   database host
#
# [*backend_user*]
#   backend user to create
#
# [*backend_email*]
#   backend user e-mail
#
# [*backend_pw*]
#   backend user default password (you can change it latter)
#
# [*mysql_root_pw*]
#   bundled mysql root password (only used if use_bundled_db = true)
#
# [*mysql_user*]
#   bundled mysql app user (only used if use_bundled_db = true)
#
# [*mysql_password*]
#   bundled mysql app user password (only used if use_bundled_db = true)
#
# [*mysql_database*]
#   bundled mysql app user database (only used if use_bundled_db = true)
#
# [*use_ssl*]
#   where to enable https 
#
# [*ssl_key*]
#   ssl cert
#
# [*ssl_cert*]
#   ssl key
#
class doc
class dockerapp_fusio  (
  $service_name = 'fusio',
  $version = 'latest',
  $ports = '80:80',
  $ssl_ports = '443:443',
  $host_name = 'apldc1vds0044.fgv.br',
  $project_key = '42eec18ffdbffc9fda6110dcc705d6ce',
  $env = 'prod',
  $use_bundled_db = true,
  $db_name = 'fusio',
  $db_user = 'fusio',
  $db_pw = '61ad6c605975',
  $db_host = 'mysql_fusio',
  $backend_user = 'demo',
  $backend_email = 'demo@fusio-project.org',
  $backend_pw = '75dafcb12c4f',
  $mysql_root_pw = '7f3e5186032a',
  $mysql_user = 'fusio',
  $mysql_password = '61ad6c605975',
  $mysql_database = 'fusio'
  $use_ssl = false,
  $ssl_cert = '',
  $ssl_key = ''
  ){

  include 'dockerapp'

  $dir_owner = 33
  $dir_group = 33

  $data_dir = $::dockerapp::params::data_dir
  $config_dir = $::dockerapp::params::config_dir
  $scripts_dir = $::dockerapp::params::scripts_dir
  $lib_dir = $::dockerapp::params::lib_dir
  $log_dir = $::dockerapp::params::log_dir

  $conf_datadir = "${data_dir}/${service_name}"
  $conf_configdir = "${config_dir}/${service_name}"
  $conf_scriptsdir = "${scripts_dir}/${service_name}"
  $conf_libdir = "${lib_dir}/${service_name}"
  $conf_logdir = "${log_dir}/${service_name}"

  if !defined(File[$conf_datadir]){
    file{ $conf_datadir:
      ensure  => directory,
      require => File[$data_dir],
      owner   => $dir_owner,
      group   => $dir_group,
    }
  }

  if !defined(File[$conf_configdir]){
    file{ $conf_configdir:
      ensure  => directory,
      require => File[$config_dir],
      owner   => $dir_owner,
      group   => $dir_group,
    }
  }

  if !defined(File[$conf_scriptsdir]){
    file{ $conf_scriptsdir:
      ensure  => directory,
      require => File[$scripts_dir],
      owner   => $dir_owner,
      group   => $dir_group,
    }
  }
  if !defined(File[$conf_logdir]){
    file{ $conf_logdir:
      ensure  => directory,
      require => File[$lib_dir],
      owner   => $dir_owner,
      group   => $dir_group,
    }
  }
  if !defined(File[$conf_libdir]){
    file{ $conf_libdir:
      ensure  => directory,
      require => File[$log_dir],
      owner   => $dir_owner,
      group   => $dir_group,
    }
  }

  file{ "${conf_datadir}/public":
    ensure  => directory,
    require => File[$conf_datadir],
    owner   => $dir_owner,
    group   => $dir_group,
  }
  ->file{ "${conf_datadir}/public/apps":
    ensure  => directory,
    owner   => $dir_owner,
    group   => $dir_group,
  }
  ->file{ "${conf_datadir}/public/customphp":
    ensure  => directory,
    owner   => $dir_owner,
    group   => $dir_group,
  }

  if($use_ssl) {
    file{ "${conf_configdir}/apache":
      ensure  => directory,
      require => File[$conf_configdir],
      owner   => $dir_owner,
      group   => $dir_group,
    }
    ->file{ "${conf_configdir}/apache/default-ssl.conf":
      ensure  => file,
      source => 'puppet:///modules/dockerapp_fusio/default-ssl.conf',
      owner   => $dir_owner,
      group   => $dir_group,
    }
    file{ "${conf_configdir}/certs":
      ensure  => directory,
      require => File[$conf_configdir],
      owner   => $dir_owner,
      group   => $dir_group,
    }
    ->file{ "${conf_configdir}/certs/fusio.pem":
      ensure  => file,
      owner   => $dir_owner,
      group   => $dir_group,
      content => $ssl_cert
    }
    ->file{ "${conf_configdir}/certs/fusio.key":
      ensure  => file,
      owner   => $dir_owner,
      group   => $dir_group,
      content => $ssl_key
    }
  }

  file {"${conf_configdir}/docker-composer.yml":
    content => epp('dockerapp_fusio/docker-composer.yml.epp', { 
      'version'        => $version, 
      'ports'          => $ports, 
      'ssl_ports'      => $ssl_ports
      'data_dir'       => $conf_datadir,
      'scriptsdir'     => $conf_scriptsdir,
      'host'           => $host_name,
      'project_key'    => $project_key,
      'env'            => $env ,
      'db_name'        => $db_name ,
      'db_user'        => $db_user ,
      'db_pw'          => $db_pw ,
      'db_host'        => $db_host ,
      'backend_user'   => $backend_user ,
      'backend_email'  => $backend_email ,
      'backend_pw'     => $backend_pw ,
      'mysql_root_pw'  => $mysql_root_pw ,
      'mysql_user'     => $mysql_user ,
      'mysql_password' => $mysql_password ,
      'mysql_database' => $mysql_database ,
      'use_bundled_db' => $use_bundled_db,
      'use_ssl'        => $use_ssl,
      'conf_configdir' => $conf_configdir
        }),
    require => File[$conf_configdir],
    notify  => Docker_compose["dk_${service_name}"],
  }

  docker_compose { "dk_${service_name}":
    compose_files => ["${conf_configdir}/docker-composer.yml"],
    ensure  => present,
  }

  #notify  => Docker::Run[$service_name],

}