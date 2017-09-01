class all::services {

	service { 'httpd':
	    name    => 'httpd',
	    ensure  => running,
	    require => Package['httpd'],
	}

} # end class all::services