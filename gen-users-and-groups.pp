# Manifests -  Criação de Utilizadores e Grupos

# utilizar o seguinte comando para gerar passwords encriptadas:

    /*   python -c 'import crypt,getpass; \
    print(crypt.crypt(getpass.getpass(), \
    crypt.mksalt(crypt.METHOD_SHA512)))'
    */

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