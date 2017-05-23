# manifest cria crons

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

cron { 'copiahtmltodocroot':
	command		=> '/usr/bin/cp -va /tmp/tetra/index.html /var/www/bacalhau',
	user 		=> 'root',
	month		=> '*',
	monthday	=> '*',
	hour		=> '23',
	minute		=> '30',
}