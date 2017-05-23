# manifesto cria ficheiros / directorias

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

file { '/etc/slb':
	ensure => 'directory',
	owner  => 'root',
	group  => 'margem' , # grupo criado no manifest "gen-users-and-groups.pp"
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
	group  => 'seixal', # grupo criado no manifest "gen-users-and-groups.pp"
	mode   => '0774',
}

# cria os seguintes ficheiros caso os mesmos não existam, com o owner,grupo,permissões e conteúdo definido nas variáveis no topo

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