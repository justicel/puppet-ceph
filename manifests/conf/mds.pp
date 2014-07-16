define ceph::conf::mds (
  $mds_data,
  $fsid,
) {

  @@concat::fragment { "ceph-mds-${name}.conf":
    target  => '/etc/ceph/ceph.conf',
    order   => '60',
    content => template('ceph/ceph.conf-mds.erb'),
    tag     => $fsid,
  }

}
