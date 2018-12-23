# nclml_robot
Nathanael's Camera, Lidar, Mapping and Localisation project

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

# Codebase
main launch file uses arguments to launch specific functionality (ie, cameras, lidar, etc)
```
roslaunch nclml_robot robot_main.launch  
```
