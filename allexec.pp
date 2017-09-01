
 class all::exec {

	exec { 'firewall-cmd --permanent --add-service=http':
	  		path    => ['/usr/bin'],
			unless  => "firewall-cmd --permanent --list-all | grep -w http",
	}

	exec { 'firewall-cmd --permanent --add-service=https':
			unless  => "firewall-cmd --permanent --list-all | grep -w https", 
	  		path    => ['/usr/bin'], 
	}

	exec { 'firewall-cmd --reload':
	  		path    => ['/usr/bin'], 
	}

	exec { 'cp -va index.html /var/www/bacalhau':
	  		cwd       => '/tmp/tetra', # vai buscar o index.html a este directorio
	  		path      => ['/usr/bin', '/usr/sbin',], # vai correr o comando 'cp' a partir destes directorios
	  		unless	=> "find /var/www -name bacalhau",
	}

	exec { 'sed -i s/SELINUX=disabled/SELINUX=enforcing/g /etc/sysconfig/selinux ; setenforce 1': # coloca o selinux como enforcing no /etc/sysconfic/selinux
  			#cwd     => '/etc/sysconfig/selinux', 
  			path    => ['/usr/bin', '/usr/sbin',], 
			unless	=> "grep SELINUX=enforcing /etc/sysconfig/selinux",
	}

	exec { 'setenforce 1': # força o selinux a estar enforced
			path    => ['/usr/bin/','/usr/sbin',],
			unless  =>  "grep SELINUX=enforcing /etc/sysconfig/selinux",
	}		
} # end class all::exec