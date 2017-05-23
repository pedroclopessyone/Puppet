# EXEC examples

exec { 'cp -va index.html /var/www/bacalhau':
  cwd     => '/tmp/tetra', # vai buscar o ficheiro index.html a este directorio
  path    => ['/usr/bin', '/usr/sbin',], # vai "buscar" o comando 'cp' a estes directorios
}

exec { 'sed -i s/SELINUX=disabled/SELINUX=enforcing/g /etc/sysconfig/selinux':
  		#cwd     => '/etc/sysconfig/selinux', 
  		path    => ['/usr/bin', '/usr/sbin',], 
}

exec { 'setenforce 1':
  		#cwd     => '/etc/sysconfig/selinux', 
		path    => ['/usr/sbin',], 
}	