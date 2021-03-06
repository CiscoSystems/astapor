# Class for nodes running any OpenStack services
class quickstack::openstack_common {

  include quickstack::firewall::common
  if (str2bool($::selinux) and $::operatingsystem != "Fedora") {
      package{ 'openstack-selinux':
          ensure => present, }
  }

  # Stop firewalld since everything uses iptables
  # for now (same as packstack did)
  service { "firewalld":
    ensure => "stopped",
    enable => false,
  }

  service { "auditd":
    ensure => "running",
    enable => true,
  }
}
