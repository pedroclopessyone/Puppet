# Install and configure MySQL (also creates databases and assign users and passwords)


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
