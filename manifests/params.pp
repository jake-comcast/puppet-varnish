# == Class: varnish::params
#

class varnish::params {

  # set Varnish conf location based on OS
  case $::osfamily {
    'RedHat': {
      if versioncmp($::operatingsystemmajrelease, '7') >= 0 {
        $conf_file_path = '/etc/varnish/varnish.params'
        $ncsa_file_path = '/etc/varnish/varnishncsa.params'
      } else {
        $conf_file_path = '/etc/sysconfig/varnish'
        $ncsa_file_path = '/etc/sysconfig/varnishncsa'
      }
    }
    default: {
      $conf_file_path = '/etc/default/varnish'
      $ncsa_file_path = '/etc/default/varnishncsa'
    }
  }

  $version = $varnish::version ? {
    /4\..*/ => '4',
    default => $varnish::default_version,
  }
}
