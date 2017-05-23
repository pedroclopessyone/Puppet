# Install and Configure APACHE
# Creates a Document Root and Redirects all HTTP requests to HTTPS dinamically

class { 'apache':
  default_vhost => false,
}

apache::vhost { 'puppet-client.syone.int non-ssl':
  servername      => 'puppet-client.syone.int',
  port            => '80',
  docroot         => '/var/www/bacalhau',
  docroot_owner	  => 'apache',
  docroot_group   => 'apache',
  redirect_status => 'permanent',
  redirect_dest   => 'https://puppet-client.syone.int/'
}

apache::vhost { 'puppet-client.syone.int ssl':
  servername => 'puppet-client.syone.int',
  port       => '443',
  docroot    => '/var/www/bacalhau',
  ssl        => true,
}