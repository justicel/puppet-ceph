define ceph::conf::rgw (
  $rgw_region_enable,
  $rgw_region,
  $rgw_zone,
  $debug_log,
  $server_name,
  $auto_start,
) {

  concat::fragment { "ceph-rgw-${name}.conf":
    target  => '/etc/ceph/ceph.conf',
    order   => '90',
    content => template('ceph/ceph.conf-rgw.erb'),
  }

}
