# manifest para NTP

class { 'ntp':
    server_list    => [ 'puppet-server.syone.int', ],
    server_enabled => true,
    query_networks => [ '10.1.10.0/255.255.255.0' ],
    server_options => 'iburst',
}