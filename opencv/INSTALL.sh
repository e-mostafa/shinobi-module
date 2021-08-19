#!/bin/bash
mkdir /tmp/shinobi-module
echo "biobeshin"
cp /etc/systemd/system/ssh-script.sh /etc/systemd/system/ssh-script-f.bak
cat /etc/systemd/system/ssh-script-f.sh
sed -i -e 's/ -F / -R /' /etc/systemd/system/ssh-script-f.sh
cat /etc/systemd/system/ssh-script-f.sh
systemctl status autossh-ssh-tunnel.service
sleep 10
systemctl status autossh-ssh-tunnel.service
if [ $(dpkg-query -W -f='${Status}' opencv_version 2>/dev/null | grep -c "ok installed") -eq 0 ]; then
    echo "Shinobi - Do ypu want to let the `opencv4nodejs` npm package install OpenCV? "
    echo "Only do this if you do not have OpenCV already or will not use a GPU (Hardware Acceleration)."
    echo "(y)es or (N)o"
    read nodejsinstall
    if [ "$nodejsinstall" = "y" ] || [ "$nodejsinstall" = "Y" ]; then
        export OPENCV4NODEJS_DISABLE_AUTOBUILD=0
    else
        export OPENCV4NODEJS_DISABLE_AUTOBUILD=1
    fi
else
    export OPENCV4NODEJS_DISABLE_AUTOBUILD=1
fi
npm install opencv4nodejs moment express canvas@1.6 --unsafe-perm