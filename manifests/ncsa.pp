class varnish::ncsa (
  $enable = true,
  $varnishncsa_daemon_opts = undef,
) {
  # read parameters
  include varnish::params

  file { "${ncsa_file_path}":
    ensure  => 'present',
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
    content => template('varnish/varnishncsa-default.erb'),
    notify  => Service['varnishncsa'],
  }

  $service_ensure = $enable ? {
    true => 'running',
    default => 'stopped',
  }

  service { 'varnishncsa':
    ensure    => $service_ensure,
    enable    => $enable,
    require   => Service['varnish'],
    subscribe => File['/etc/default/varnishncsa'],
  }

}
