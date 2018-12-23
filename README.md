# nclml_robot
Nathanael's Camera, Lidar, Mapping and Localisation robot project

# Hardware
* iRobot Create® 2 Programmable Robot

* RPLidar A2

* UM7 IMU

* PrimeSense Camera

* Jetson TX1

# Software
* [create_autonomy](http://wiki.ros.org/create_autonomy)

* [rviz](http://wiki.ros.org/rviz)

* [rplidar](http://wiki.ros.org/rplidar)

* [um7](http://wiki.ros.org/um7)

* [robot_localization](http://wiki.ros.org/robot_localization)

* [teleop_twist_keyboard](http://wiki.ros.org/teleop_twist_keyboard)

# Resources
* [ROS Navigation Tuning Guide](http://kaiyuzheng.me/documents/navguide.pdf)
* [Persistent names for usb-serial devices](http://hintshop.ludvig.co.nz/show/persistent-names-usb-serial-devices/)

# Codebase

## Persistent Names for Devices
### Create2 - Persistent Naming
1. Find SUBSYSTEM, idVendor, idProduct and serial of the device 

*Note: Change "ttyUSB0" to the device you are interested in. Udevadm info starts with the device specified by the devpath and then walks up the chain of parent devices. Therefore only use the first value output for each field.*
```
udevadm info -a -n /dev/ttyUSB0 | grep -E 'SUBSYSTEM|{idVendor}|{idProduct}|{serial}'
```
2. Create UDEV rules file
```
cd /etc/udev/rules.d
sudo nano 99-usb-serial.rules
```
3. Add your rule
```
SUBSYSTEM=="tty", ATTRS{idVendor}=="0403", ATTRS{idProduct}=="6015", ATTRS{serial}=="DA01NYKQ", SYMLINK+="create2"
```
4. Change the device path for the robot inside the create driver yaml
```
rosed ca_driver default.yaml 
```
Modify
```
dev: "/dev/ttyUSB0"
```
to
```
dev: "/dev/create2"
```

## main.launch
Main launch file to run the robot
```
roslaunch nclml_robot robot_main.launch  
```
Arguments launch specific functionality
```
arg name="CREATE_DRIVER"   value="1"
arg name="LIDAR"           value="1"
arg name="IMU"             value="1"
arg name="CAMERA"          value="1"
```
Robots namespace
```
arg name="namespace" default="nclml"
```

## imu.launch
Launches um7 imu node
