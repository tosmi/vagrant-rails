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
}

include railsdev
