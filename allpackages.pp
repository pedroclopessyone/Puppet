class all::packages {

	package { 'httpd':
	    provider => yum,
	    ensure   => installed,
	}

} # end class all::packages