
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



# cria o grupo margem com o GID 3091 e grupo seixal com GID 3092
group { 'margem':
	ensure => present,
	gid    => '3091',
}

group { 'seixal':
	ensure => present,
	gid => '3092',
}

group { 'escobar':
	gid => '3093',
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

user { 'pablo':
	ensure   => present,
	comment  => 'Pablo Escobar',
	home     => '/home/pablo',
	managehome	=> true,
	groups   => ['escobar'],
	password => '$6$mMZW9lTDGAxpj0b3$ENygOoQYNfsIx/SluYhpS1q3rpxKoxesTnOSinnYlTt5Em0tM6yLbwZmUHPeB3kPaOPu0HxC5uw/OTp7Acj1z/',
	shell    => '/bin/bash',	
}

#ssh_authorized_key { 'foreman-proxy@foreman.redhat.local':
#  user => 'foreman-proxy',
#  type => 'ssh-rsa',
#  key  => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQDDNHDxwrp7Dz3zRmH/utQtsW7rQYDJocey0ouPGN2+lItd5kKwj3azkWWYq0iXZEyQ/wGI/KxVGA+SYDJtwOemkuUnwWxjqbidt9nvaDRsHB7yOkwPmjrRXTicgTVMIhFt1FUcuOAeQuFx0/KCwDwUgtLKnkArj0sivBSacJC42OtjYK0oZJw0ehxDAr3FByH37HncN/f+DsAey0lr2lFWYpExKnMpCMMu68dyenNFfDdIdbX41JQNzqnCng6yEdKWeE/nkS8Je616+/m1sPEcl8O/z78Iw0onu/lGqfj2HvtSQZh19NLPwgO/orzlKbjnEiPcd7ovYo7DLjGDYFP9',
#}

#user { 'foreman-proxy':
#  ensure         => present,
#  purge_ssh_keys => true,
#}

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


##########################################
# o campo 'service' em baixo foi comentado porque já está declarado no ficheiro /etc/puppet/modules/ntp/manifests/init.pp e estava a dar conflito quando se corria o agente
#########################################
#service { 'ntpd':
#    enable      => true,
#    ensure      => running,
#    require	=> Class["ntp"],
#} # end service ntpd declaration


############### HTTP - virtual host Seccion ###############


/*class { 'apache':
  default_vhost => false,
}

node "foreman-client.syone.int" {
  
apache::vhost { 'foreman-client.syone.int non-ssl':
  servername      => 'foreman-client.syone.int',
  port            => '80',
  docroot         => '/var/www/bacalhau',
  docroot_owner	  => 'apache',
  docroot_group   => 'apache',
  redirect_status => 'permanent',
  redirect_dest   => 'https://foreman-client.syone.int/'
}

apache::vhost { 'foreman-client.syone.int ssl':
  servername => 'foreman-client.syone.int',
  port       => '443',
  docroot    => '/var/www/bacalhau',
  ssl        => true,
}

} # end node puppet-client.syone.int
*/

############## FIREWALL RULES FOR APACHE #################
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
############## FIREWALL RULES FOR APACHE #################



############### Passagem do ficheiro index.html para o document root do virtual host #############

exec { 'cp -va index.html /var/www/bacalhau':
  cwd       => '/tmp/tetra', # vai buscar o index.html a este directorio
  path      => ['/usr/bin', '/usr/sbin',], # vai correr o comando 'cp' a partir destes directorios
  unless	=> "find /var/www -name bacalhau",
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
		unless	=> "grep SELINUX=enforcing /etc/sysconfig/selinux",
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



