#
# yum module
#
# Copyright 2008, admin(at)immerda.ch
# Copyright 2008, Puzzle ITC GmbH
# Marcel Härry haerry+puppet(at)puzzle.ch
# Simon Josi josi+puppet(at)puzzle.ch
#
# This program is free software; you can redistribute
# it and/or modify it under the terms of the GNU
# General Public License version 3 as published by
# the Free Software Foundation.
#
class yum(
  $centos_testing_include_pkgs = '',
  $centos_testing_exclude_pkgs = '',
  $manage_munin                = false,
  $repo_stage                  = 'main'
) {
  # autoupdate
  package {
    'yum-cron' :
      ensure => present
  } -> service {
    'yum-cron' :
      ensure => running,
      enable => true,
  }
  case $::operatingsystem {
    centos : {
      class{[ 'yum::centos::base',
              'yum::prerequisites' ]:
        stage => $repo_stage,
      }
      if $::operatingsystemmajrelease > 6 {
        file_line{
          'enable_autoupdate':
            line   => 'apply_updates = yes',
            match  => '^apply_updates',
            path   => '/etc/yum/yum-cron.conf',
            notify => Service['yum-cron'];
          'silence_update':
            line   => 'update_messages = no',
            match  => '^update_messages',
            path   => '/etc/yum/yum-cron.conf',
            notify => Service['yum-cron'];
        }
      } elsif $::operatingsystemmajrelease == 5 {
        class{'yum::centos::five':
          stage => $repo_stage,
        }
      }
    }
    amazon : {
      class{[ 'yum::amazon::base',
              'yum::prerequisites' ]:
        stage => $repo_stage,
      }
    }
    default : {
      fail('no managed repo yet for this distro')
    }
  }
  if $yum::manage_munin {
    include ::yum::munin
  }
}
