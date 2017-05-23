# configure selinux policies for http	
    
    selboolean { 'httpd_can_network_connect':
	name		=> 'httpd_can_network_connect',
	persistent	=> 'true',
	provider	=> 'getsetsebool',
	value		=> 'on',
}

	selboolean { 'httpd_builtin_scripting':
	name		=> 'httpd_builtin_scripting',
	persistent	=> 'true',
	provider	=> 'getsetsebool',
	value		=> 'on',
}

	selboolean { 'httpd_can_network_connect_db':
	name		=> 'httpd_can_network_connect_db',
	persistent	=> 'true',
	provider	=> 'getsetsebool',
	value		=> 'on',
}

	selboolean { 'httpd_can_sendmail':
	name		=> 'httpd_can_sendmail',
	persistent	=> 'true',
	provider	=> 'getsetsebool',
	value		=> 'on',
}


	selboolean { 'httpd_enable_homedirs':
	name		=> 'httpd_enable_homedirs',
	persistent	=> 'true',
	provider	=> 'getsetsebool',
	value		=> 'on',
}


	selboolean { 'httpd_read_user_content':
	name		=> 'httpd_read_user_content',
	persistent	=> 'true',
	provider	=> 'getsetsebool',
	value		=> 'on',
}