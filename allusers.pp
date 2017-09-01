class all::users {

	user { 'benfica':
	  	ensure  				=> present,
	  	comment 				=> 'Sport Lisboa User',
	  	home    				=> '/home/benfica',
	  	managehome				=> true,
	  	uid    					=> 501,
		gid 					=> 3091,
		groups					=> ['margem', 'wheel'],
		password_max_age			=> 36000,
		password_min_age			=> 1,
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
		ensure          => present,
		comment  		=> 'Pablo Escobar',
		home     		=> '/home/pablo',
		managehome		=> true,
		groups          => ['escobar'],
		password        => '$6$mMZW9lTDGAxpj0b3$ENygOoQYNfsIx/SluYhpS1q3rpxKoxesTnOSinnYlTt5Em0tM6yLbwZmUHPeB3kPaOPu0HxC5uw/OTp7Acj1z/',
		shell           => '/bin/bash',	
	}


	user { 'rui.costa':
		ensure          => present,
		comment  		=> 'Rui Costa',
		home     		=> '/home/rui.costa',
		managehome		=> true,
		groups          => ['seixal'],
		password        => '$6$mMZW9lTDGAxpj0b3$ENygOoQYNfsIx/SluYhpS1q3rpxKoxesTnOSinnYlTt5Em0tM6yLbwZmUHPeB3kPaOPu0HxC5uw/OTp7Acj1z/',
		shell           => '/bin/bash',	
	}

} # end class all users