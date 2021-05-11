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

class dockerapp_fusio  (
  $service_name = 'fusio',
  $version = '2.0.0',
  $ports = '80:80',

  ){

  include 'dockerapp'

  $dir_owner = 0
  $dir_group = 0

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

 
  file {"${conf_configdir}/docker-composer.yml":
    content => epp('dockerapp_fusio/docker-composer.yml.epp', { 
      'version' => $version, 
      'ports' => $ports, 
      'data_dir' => $conf_datadir,  }),
    require => File[$conf_configdir],
    notify  => Docker_compose["dk_${service_name}"],
  }

  docker_compose { "dk_${service_name}":
    compose_files => ["${conf_configdir}/docker-composer.yml"],
    ensure  => present,
  }

  #notify  => Docker::Run[$service_name],

}