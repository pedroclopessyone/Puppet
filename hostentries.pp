class host::entries {

	host { 'foreman.redhat.local':
		ensure			=> 'present',
		ip				=> '192.168.122.51',
		host_aliases	=> 'foreman',
		target			=> '/etc/hosts',
	} # end host foreman.redhat.local

	host { 'puppetmaster.redhat.local':
		ensure			=> 'present',
		ip				=> '192.168.122.55',
		host_aliases	=> 'puppetmaster',
		target			=> '/etc/hosts',
	} # end host puppetmaster.redhat.local

	host { 'puppetmaster2.redhat.local':
		ensure			=> 'present',	
		ip				=> '192.168.122.54',
		host_aliases	=> 'puppetmaster2',
		target			=> '/etc/hosts',
	} # end host puppetmaster.redhat.local

	host { 'puppetmaster3.redhat.local':
		ensure			=> 'present',	
		ip				=> '192.168.122.56',
		host_aliases	=> 'puppetmaster3',
		target			=> '/etc/hosts',
	} # end host puppetmaster.redhat.local

} # end host_entries CLASS