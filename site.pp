
############ declaração de variáveis#################

$conteudo = 'Este é um manifesto de teste.
Conteudos simples
Conteudo de teste
'

$criaficheiro = 'Conteúdo qualquer
Ficheiro coiso
Ficheiro PT
'
$ficheirohtml = '<h1>NOVO SITE</h1>
<h2>Managed by Puppet</h2>
<h3>Pedro Cravo Lopes</h3>
'
$ficheirovazio = ''

$hosts = '
10.1.10.254 puppet-server.syone.int puppet-server
10.1.10.250 puppet-client.syone.int puppet-client
10.1.10.249 test-pp.syone.int test-pp
'
$anotherone = '

Qualquer coisa...
'
############ \declaração de variáveis#################


/* exec { 'addpuppetservertohostsfile':
	command => "echo $hosts >> /etc/hosts",
	path	=> ['/usr/bin/'],
}
*/


exec { 'addpuppetmanagednode1':
	command => "/bin/echo 10.1.10.254 puppet-server.syone.int puppet-server >> /etc/hosts",
}

exec { 'addpuppetmanagednode2':
	command => "/bin/echo 10.1.10.250 puppet-client.syone.int puppet-client >> /etc/hosts",
}

exec { 'addpuppetmanagednode3':
	command => "/bin/echo 10.1.10.249 test-pp.syone.int test-pp >> /etc/hosts",	
}

# cria o grupo margem com o GID 3091 e grupo seixal com GID 3092
group { 'margem':
	ensure => present,
	gid    => '3091',
}

group { 'seixal':
	ensure => present,
	gid => '3092',
}

user { 'benfica':
  	ensure  				=> present,
  	comment 				=> 'Sport Lisboa User',
  	home    				=> '/home/benfica',
  	managehome				=> true,
  	uid    					=> 501,
	gid 					=> 3091,
	groups					=> ['margem', 'wheel'],
	password_max_age		=> 36000,
	password_min_age		=> 1,
	shell  					=> '/bin/bash',
	password 				=> '$6$eOrTFf5gyUQ/cqdi$RxVQ3WQUZw3M.sIYj76KNXeWGjpsBo3VR0AOt0HwETkDBZd1Zogr89begC51rH0ZMYgh1OZl26w/qPaOiQzOg0',
}

user { 'plinha':
	ensure 		=> present,
	comment 	=> 'Pedro Linha',
	home 		=> '/home/plinha',
	managehome 	=> true,
	uid 		=> '502',
	gid 		=> '3092',
	groups		=> ['seixal'],
	shell 		=> '/bin/bash',
	password 	=> '$6$NPc47BqoQXCw.VOe$LXvaruy2Uj.FnrVXOOBKgIjfMEraLyVyRWC5u/yvLoIVsXuGZZ.nXpSiqEjvDhctKcSdGuCdz5a/KMv532Gzo.',
}


# cria a directoria /etc/slb

file { '/etc/slb':
	ensure => 'directory',
	owner  => 'root',
	group  => 'margem',
	mode   => '0774',
}

file { '/etc/campeao':
	ensure => 'directory',
	owner  => 'root',
	group  => 'margem',
	mode   => '0774',
}

file { '/tmp/tetra':
	ensure => 'directory',
	owner  => 'root',
	group  => 'margem',
	mode   => '0774',
}

file { '/tmp/plinhatest':
	ensure => 'directory',
	owner  => 'root',
	group  => 'seixal',
	mode   => '0774',
}

# cria os seguintes ficheiro caso os mesmos não existam, com o owner,grupo,permissões e conteúdo definido em baixo

file { '/etc/slb/tesfile2.txt':
    ensure => file,
    owner  => 'root',
    group  => 'margem',	
    mode  => 644,
    content => "$conteudo",
}

file { '/etc/campeao/ficheiro.txt':
	ensure => file,
	owner => 'benfica', 
	group => 'margem',
	mode => 644,
	content => "$criaficheiro",
}

file { '/tmp/tetra/index.html':
	ensure  => file,
	owner   => apache,
	group   => apache,
	mode    => 774,
	content => "$ficheirohtml",
}

cron { 'cp':
	command  => '/usr/bin/cp -va /etc/campeao/ficheiro.txt /tmp/tetra',
	user     => 'root',
	month    => '*',
	monthday => '*',
	hour     => '*',
	minute   => '12',
}

cron { 'date':
	command  => '/usr/bin/date >> /tmp/tetra/ficheiro.txt',
	user     => 'root',
	month    => '*',
	monthday => '*',
	hour     => '*',
	minute   => '12',
}



########### HTTP Section - Estas linhas em baixo foram comentadas porque foram configurados virtual hosts mais em baixo e fazia conflito ###############

# valida se o httpd está instalado. se não estiver, o serviço será instalado.

#package { 'httpd':
#    provider => yum,
#    ensure   => installed,
#}

# verifica se o serviço está a correr. se nao estiver, o serviço será iniciado

#service { 'httpd':
#    name    => 'httpd',
#    ensure  => running,
#    require => Package['httpd'],
#}

####################################################################################################################################################

# NTP seccion #

class { 'ntp':
    server_list    => [ 'puppet-server.syone.int', ],
    server_enabled => true,
    query_networks => [ '10.1.10.0/255.255.255.0' ],
    server_options => 'iburst',
}

##########################################
# o campo 'service' em baixo foi comentado porque já está declarado no ficheiro /etc/puppet/modules/ntp/manifests/init.pp e estava a dar conflito quando se corria o agente
#########################################
#service { 'ntpd':
#    enable      => true,
#    ensure      => running,
#    require	=> Class["ntp"],
#} # end service ntpd declaration


############### HTTP - virtual host Seccion ###############


class { 'apache':
  default_vhost => false,
}

node "puppet-client.syone.int" {
  
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

} # end node puppet-client.syone.int

node "test-pp.syone.int" {
  
apache::vhost { 'test-pp.syone.int non-ssl':
  servername      => 'test-pp.syone.int',
  port            => '80',
  docroot         => '/var/www/bacalhau',
  docroot_owner	  => 'apache',
  docroot_group   => 'apache',
  redirect_status => 'permanent',
  redirect_dest   => 'https://test-pp.syone.int/'
}

apache::vhost { 'test-pp.syone.int ssl':
  servername => 'test-pp.syone.int',
  port       => '443',
  docroot    => '/var/www/bacalhau',
  ssl        => true,
}

} # end node test-pp.syone.int

############## FIREWALL RULES FOR APACHE #################
exec { 'firewall-cmd --permanent --add-service=http':
  		path    => ['/usr/bin'], 
}
exec { 'firewall-cmd --permanent --add-service=https':
  		path    => ['/usr/bin'], 
}
exec { 'firewall-cmd --reload':
  		path    => ['/usr/bin'], 
}
############## FIREWALL RULES FOR APACHE #################



############### Passagem do ficheiro index.html para o document root do virtual host #############

exec { 'cp -va index.html /var/www/bacalhau':
  cwd     => '/tmp/tetra', # vai buscar o index.html a este directorio
  path    => ['/usr/bin', '/usr/sbin',], # vai correr o comando 'cp' a partir destes directorios
}

################################################################################################



######## cron que vai atualizado todas as alterações feitas ao ficheiro index.html a cada 5 horas ###########

cron { 'copiahtmltodocroot':
	command		=> '/usr/bin/cp -va /tmp/tetra/index.html /var/www/bacalhau',
	user 		=> 'root',
	month		=> '*',
	monthday	=> '*',
	hour		=> '*/5',
	minute		=> '*',
}

###############################################################################################################


#################################SELINUX FIELD ####################################################
	
	exec { 'sed -i s/SELINUX=disabled/SELINUX=enforcing/g /etc/sysconfig/selinux': # coloca o selinux como enforcing no /etc/sysconfic/selinux
  		#cwd     => '/etc/sysconfig/selinux', 
  		path    => ['/usr/bin', '/usr/sbin',], 
}

	exec { 'setenforce 1': # força o selinux a estar enforced
  		#cwd     => '/etc/sysconfig/selinux', 
		path    => ['/usr/sbin',], 
}	

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

################################# END SELINUX FIELD ####################################################


############ MySQL section ##########


class { '::mysql::server':
  root_password				=> 'Passw0rd', # a password não pode conter caracteres especiais (ex: !) porque dá erro no login (no mysql)
  remove_default_accounts	=> true,
#  override_options			=> $override_options # esta directiva serve para alterar configurações default do ficheiro /etc/my.cnf
}

mysql::db { 'puppettestdb':
  user     => 'pedroclopes',
  password => 'Passw0rd',
  host     => 'localhost',
  grant    => ['SELECT', 'UPDATE'],
}

mysql::db { 'bacalhaudb':
  user     => 'lopes',
  password => 'Passw0rd',
  host     => 'localhost',
  grant    => ['SELECT', 'UPDATE'],
}

############ END MySQL section ##########


