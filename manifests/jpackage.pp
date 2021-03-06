# manage jpackage for EL
class yum::jpackage {
  yum::managed_yumrepo {
    'jpackage-generic' :
      descr           => 'JPackage (free), generic',
      mirrorlist      => 'http://www.jpackage.org/jpackage_generic_1.7.txt',
      failovermethod  => 'priority',
      gpgcheck        => 1,
      gpgkey          => 'http://www.jpackage.org/jpackage.asc',
      enabled         => 1,
      priority        => 1 ;

    'jpackage-rhel' :
      descr           => 'JPackage (free) for Red Hat Enterprise Linux $releasever',
      mirrorlist      => "http://www.jpackage.org/jpackage_rhel-${::operatingsystemmajrelease}_1.7.txt",
      failovermethod  => 'priority',
      gpgcheck        => 1,
      gpgkey          => 'http://www.jpackage.org/jpackage.asc',
      enabled         => 1,
      priority        => 1 ;

    'jpackage-generic-nonfree' :
      descr           => 'JPackage (non-free), generic',
      mirrorlist      => 'http://www.jpackage.org/jpackage_generic_nonfree_1.7.txt',
      failovermethod  => 'priority',
      gpgcheck        => 1,
      gpgkey          => 'http://www.jpackage.org/jpackage.asc',
      enabled         => 1,
      priority        => 1 ;
  }
}
