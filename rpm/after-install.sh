#!/bin/bash
chkconfig --add beamium
cat << EOF > /etc/logrotate.d/beamium
/var/log/beamium/beamium.log /var/log/beamium/beamium.out /var/log/beamium/beamium.err {
  daily
  missingok
  copytruncate
  rotate 7
  compress
  delaycompress
}
EOF

/etc/init.d/beamium start
