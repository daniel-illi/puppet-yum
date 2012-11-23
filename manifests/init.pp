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
  $repo_stages                 = 'main'
) {
# autoupdate
  package {
    'yum-cron' :
      ensure => present
  }
  service {
    'yum-cron' :
      enable => true,
      ensure => running,
      hasstatus => true,
      hasrestart => true,
      require => Package[yum-cron],
  }
  case $::operatingsystem {
    centos : {
      class{'yum::centos::base':
        stage => $repo_stages,
      }
      case $::lsbmajdistrelease {
        5 : {
          class{'yum::centos::five':
            stage => $repo_stages,
          }
        }
      }
    }
    default : {
      fail("no managed repo yet for this distro")
    }
  }
  if $yum::manage_munin {
    include ::yum::munin
  }
}
