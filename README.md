# nclml_robot
Nathanael's Camera, Lidar, Mapping and Localisation robot project.

Gathering data in an unknown environment using SLAM and frontier exploration. 

Cartographer SLAM with Hector Exploration.

# Hardware
* iRobot Create® 2 Programmable Robot
* RPLidar A2
* UM7 IMU
* RealSense R200 Camera
* Jetson TX1

# Software

## Hardware Packages
* [create_autonomy](http://wiki.ros.org/create_autonomy)
* [rplidar](http://wiki.ros.org/rplidar)
* [um7](http://wiki.ros.org/um7)

## Visualisation & Manual Control
* [rviz](http://wiki.ros.org/rviz)
* [teleop_twist_keyboard](http://wiki.ros.org/teleop_twist_keyboard)

## SLAM packages
* [cartographer_ros](https://github.com/googlecartographer/cartographer_ros)
* [gmapping](http://wiki.ros.org/gmapping)
* [robot_localization](http://wiki.ros.org/robot_localization)

## Exploration packages
* [hector_exploration_planner](http://wiki.ros.org/hector_exploration_planner)

# Resources
* [ROS Navigation Tuning Guide](http://kaiyuzheng.me/documents/navguide.pdf)
* [Persistent names for usb-serial devices](http://hintshop.ludvig.co.nz/show/persistent-names-usb-serial-devices/)
* [A Platform for Indoor Localisation, Mapping, and Data Collection using an Autonomous Vehicle](http://lup.lub.lu.se/luur/download?func=downloadFile&recordOId=8915402&fileOId=8915426)
* [Cartographer ROS Integration](https://google-cartographer-ros.readthedocs.io/en/latest/)

# Codebase

## Setup Codebase

### Persistent Names for USB Serial Devices
1. Find device USB port name
```
udevadm monitor
```
2. Plug/unplug your device and look for *"ttyUSB0"*
```
KERNEL[59094.407544] remove   /devices/pci0000:00/0000:00:14.0/usb1/1-3/1-3.4/1-3.4:1.0/ttyUSB0/tty/ttyUSB0 (tty)
KERNEL[59094.407631] remove   /devices/pci0000:00/0000:00:14.0/usb1/1-3/1-3.4/1-3.4:1.0/ttyUSB0 (usb-serial)
KERNEL[59094.407759] remove   /devices/pci0000:00/0000:00:14.0/usb1/1-3/1-3.4/1-3.4:1.0 (usb)
KERNEL[59094.408442] remove   /devices/pci0000:00/0000:00:14.0/usb1/1-3/1-3.4 (usb)
KERNEL[59094.408825] remove   /devices/pci0000:00/0000:00:14.0/usb1/1-3/1-3:1.0 (usb)
KERNEL[59094.409507] remove   /devices/pci0000:00/0000:00:14.0/usb1/1-3 (usb)
UDEV  [59094.425841] remove   /devices/pci0000:00/0000:00:14.0/usb1/1-3/1-3.4/1-3.4:1.0/ttyUSB0/tty/ttyUSB0 (tty)
UDEV  [59094.426082] remove   /devices/pci0000:00/0000:00:14.0/usb1/1-3/1-3:1.0 (usb)
UDEV  [59094.426230] remove   /devices/pci0000:00/0000:00:14.0/usb1/1-3/1-3.4/1-3.4:1.0/ttyUSB0 (usb-serial)
UDEV  [59094.426960] remove   /devices/pci0000:00/0000:00:14.0/usb1/1-3/1-3.4/1-3.4:1.0 (usb)
UDEV  [59094.427408] remove   /devices/pci0000:00/0000:00:14.0/usb1/1-3/1-3.4 (usb)
UDEV  [59094.428014] remove   /devices/pci0000:00/0000:00:14.0/usb1/1-3 (usb)
```
3. Find SUBSYSTEM, idVendor, idProduct and serial of the device 

*Note: Change "ttyUSB0" to the device you are interested in. Udevadm info starts with the device specified by the devpath and then walks up the chain of parent devices. Therefore only use the first value output for each field.*
```
udevadm info -a -n /dev/ttyUSB0 | grep -E 'SUBSYSTEM|{idVendor}|{idProduct}|{serial}'
```
4. Create UDEV rules file
```
sudo nano /etc/udev/rules.d/99-usb-serial.rules
```
5. Add your rule
```
SUBSYSTEM=="tty", ATTRS{idVendor}=="0403", ATTRS{idProduct}=="6001", ATTRS{serial}=="A6006B1W", SYMLINK+="um7"
```
#### Create_2 - Persistent Naming
Follow steps in "Codebase > Persistent Names for USB Serial Devices" 
```
SYMLINK+="create_2"
```
Change the device path for the robot inside the create driver yaml
```
rosed ca_driver default.yaml 
```
Modify
```
dev: "/dev/ttyUSB0"
```
to
```
dev: "/dev/create_2"
```
#### RPLidar_A2 - Persistent Naming
Should have been completed in setting up ros rplidar package
```
/dev/rplidar
``` 
#### UM7_IMU - Persistent Naming
Follow steps in "Codebase > Persistent Names for USB Serial Devices" 
```
SYMLINK+="um7"
```
#### RealSense_R200 - Persistent Naming
Follow steps in "Codebase > Persistent Names for USB Serial Devices" 
```
SYMLINK+="realsense_r200"
```
### Install cartographer_ros
https://google-cartographer-ros.readthedocs.io/en/latest/compilation.html

## Running Codebase

### main.launch
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

### imu.launch
Launches UM7 IMU node
