define ceph::conf::rgw (
  $rgw_region_enable = false,
  $rgw_region        = '',
  $rgw_zone          = '',
  $auto_start        = true,
) {

  concat::fragment { "ceph-rgw-${name}.conf":
    target  => '/etc/ceph/ceph.conf',
    order   => '90',
    content => template('ceph/ceph.conf-rgw.erb'),
  }

}
