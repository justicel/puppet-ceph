# Add users to a radosgw
#
# == Parameters
# [*user*] The user name to add
#   Mandatory. Default "admin"
#
# [*key*] The key of the admin user
#   Optional. Generated by default.
#
# [*swift_user*] Additionally create swift subuser
#   Optional.
#
# [*swift_key*] The key of the admin user
#   Optional.
#
# == ToDo
#
# == Dependencies
# rgw.pp
#
# == Authors
#
#  Marc Koderer m.koderer@telekom.de
#
# == Copyright
#
# Copyright 2013 Deutsche Telekom AG
#


define ceph::rgw_user (
  $user       = 'admin',
  $key        = '--gen-secret',
  $swift_user = undef,
  $swift_key  = '--gen-secret',
  $rgwname    = 'gateway',
) {
  if $key != '--gen-secret'{
    $key_opt = "--secret ${key}"
  } else{
    $key_opt = $key
  }

  exec { 'add-user':
    command => "radosgw-admin user create --uid=${user} \
 ${key_opt} --display-name ${user} --name=client.radosgw.${rgwname}",
    require => Service['radosgw'],
    unless  => "radosgw-admin user info --uid=${user} --name=client.radosgw.${rgwname}"
  }

  if ($swift_user){

    if $swift_key != '--gen-secret'{
      $swift_key_opt = "--secret ${swift_key}"
    } else{
      $swift_key_opt = $swift_key
    }

    exec { 'add-swift-subuser':
      command => "radosgw-admin subuser create \
--uid=${user} --subuser=${swift_user} \
${swift_key_opt} --display-name ${swift_user} \
--key-type swift --access=full",
      require => Exec['add-user'] ,
      unless  => "radosgw-admin user info --uid=${user}|grep ${user}:${swift_user}"
    }
  }
}
