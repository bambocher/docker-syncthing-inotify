#!/bin/ash

echo [OK] Waiting for http://syncthing:8384

timeout ash <<EOT
while ! (curl -sm1 http://syncthing:8384) >/dev/null 2>&1; do
    sleep 1;
done;
EOT

if [ $? -eq 0 ]; then
    syncthing-inotify $@
else
    echo [FATAL] Timeout waiting for http://syncthing:8384 1>&2;
fi
