#!/bin/bash
chkconfig --add noderig
cat << EOF > /etc/logrotate.d/noderig
/var/log/noderig/noderig.out /var/log/noderig/noderig.err {
  daily
  missingok
  copytruncate
  rotate 7
  compress
  delaycompress
}
EOF

/etc/init.d/noderig start
