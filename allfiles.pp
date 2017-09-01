class all::files {

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

	file { '/tmp/imagens':
		ensure => 'directory',
		owner  => 'puppet',
		group  => 'root',
		mode   => '0774',
	}

	file { '/tmp/imagens/meo_logo.png':
		ensure => file,
		owner  => puppet,
		group  => root,
		mode   => 0774,
		source => "puppet:///modules/smartdesk/meo.png", # esta source mapeia para "/etc/puppet/environments/production/modules/smartdesk/files"
	}

} # end class all::files