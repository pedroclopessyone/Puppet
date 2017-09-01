class all::crons {

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
		hour		=> '*/5',
		minute		=> '*',
	}

	cron {'run-puppet-at-boot':
		command		=> '/usr/bin/puppet/ puppet agent -t',
		user		=> 'root',
		ensure		=> 'present',
		special		=> 'reboot',
	}

} # end class all::crons
