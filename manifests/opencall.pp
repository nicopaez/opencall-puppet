include git

include rvm

rvm::system_user { 'ubuntu':  ; 'root': ; 'vagrant': ;}

rvm_system_ruby { 'ruby-2.2.1':
ensure      => 'present',
default_use => true,
} -> notify {'ruby-ready':
    message => 'Ruby installation is ready',
  }

rvm_gem { 'bundler':
ensure       => latest,
name         => 'bundler',
ruby_version => 'ruby-2.2.1',
require      => Rvm_system_ruby['ruby-2.2.1'];
}

class { 'elasticsearch':
  package_url       => 'https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-1.4.2.deb',
  java_install => true,
}

class { 'postgresql::globals':
manage_package_repo => true,
version             => '9.3',
} ->
class { 'postgresql::server': }

postgresql::server::db { 'opencall':
user     => 'opencall',
password => postgresql_password('opencall', 'opencall'),
}

postgresql::server::role { 'opencall':
superuser     => true,
password_hash => postgresql_password('opencall', 'opencall'),
}

class { 'postgresql::lib::devel': }
