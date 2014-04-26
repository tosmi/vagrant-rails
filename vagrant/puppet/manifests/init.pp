class railsdev {

  exec { 'devtools':
    unless  => '/usr/bin/yum grouplist "Development tools" | /bin/grep "^Installed Groups"',
    command => '/usr/bin/yum -y groupinstall "Development tools"',
  } ->
  class { 'rvm':
    system_users  => ['vagrant'],
  } ->
  rvm_system_ruby { 'ruby-2.1.1':
    ensure => present,
    default_use => true,
  } 

  rvm_gemset {
    'ruby-2.1.1@railsdev':
      ensure  => present,
      require => Rvm_system_ruby['ruby-2.1.1'];
  } 

  rvm_gem {
    'ruby-2.1.1@railsdev/rails':
      ensure  => '4.1',
      require => Rvm_gemset['ruby-2.1.1@railsdev'];
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
}

include railsdev
