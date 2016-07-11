class railsdev {

  exec { 'devtools':
    unless  => '/usr/bin/yum grouplist "Development tools" | /bin/grep "^Installed Groups"',
    command => '/usr/bin/yum -y groupinstall "Development tools"',
  } ->
  class { 'rvm':
    system_users  => ['vagrant'],
  } ->
  rvm_system_ruby { 'ruby-2.2.5':
    ensure => present,
    default_use => true,
  }

  rvm_gemset {
    'ruby-2.2.5@railsdev':
      ensure  => present,
      require => Rvm_system_ruby['ruby-2.2.5'];
  }

  rvm_gem {
    'ruby-2.2.5@railsdev/rails':
      ensure  => '5.0.0',
      require => Rvm_gemset['ruby-2.2.5@railsdev'];
  }

  require postgresql::server
  require postgresql::client

  postgresql::server::role { 'railsdev':
    password_hash => postgresql_password('railsdev', 'railsdev'),
  } ->
  postgresql::server::db { 'railsdev':
    user     => 'railsdev',
    password => postgresql_password('railsdev', 'railsdev'),
  }

  package { 'sqlite-devel':
    ensure => 'installed',
  }

  yumrepo { 'epel':
    mirrorlist     => 'https://mirrors.fedoraproject.org/mirrorlist?repo=epel-7&arch=\$basearch'
    baseurl        => 'absent',
    failovermethod => 'priority',
    enabled        => true,
    gpgcheck       => false,
    gpgkey         => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-7",
    descr          => "Extra Packages for Enterprise Linux 7 - \$basearch",
  } ->
  package { 'nodejs':
    ensure => 'installed',
  }

  
}

include railsdev
