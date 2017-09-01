class all::groups {

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

} # end class all groups
