#!/bin/bash

echo "start copy 99-nclml-robot.rules to  /etc/udev/rules.d/"
echo "`rospack find nclml_robot`/scripts/include/99-nclml-robot.rules"
sudo cp `rospack find nclml_robot`/scripts/include/99-nclml-robot.rules  /etc/udev/rules.d
echo " "
echo "Restarting udev"
echo ""
sudo service udev reload
sudo service udev restart
echo "Finished"
