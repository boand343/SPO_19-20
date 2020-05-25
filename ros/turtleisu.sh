#222222222222
rosservice call turtle1/teleport_absolute 1 8 1.57
rosservice call clear
rosservice call kill /turtle2
rostopic pub -1 /turtle1/cmd_vel geometry_msgs/Twist -- '[2, 0.0, 0.0]' '[0.0, 0.0, -3.14]'
rosservice call turtle1/teleport_absolute 1 6 0
rostopic pub -1 /turtle1/cmd_vel geometry_msgs/Twist -- '[1, 0.0, 0.0]' '[0.0, 0.0, 0]'
#555555555555555
rosservice call spawn 4 8.5 3.14 /turtle2
rostopic pub -1 /turtle2/cmd_vel geometry_msgs/Twist -- '[1, 0.0, 0.0]' '[0.0, 0.0, 0]'
rosservice call turtle2/teleport_absolute 3 7.75 0
rostopic pub -1 /turtle2/cmd_vel geometry_msgs/Twist -- '[3, 0.0, 0.0]' '[0.0, 0.0, -3.14]'
rosservice call kill /turtle2
#777777777777777
rosservice call spawn 4.5 8.5 0 /turtle2
rostopic pub -1 /turtle2/cmd_vel geometry_msgs/Twist -- '[1, 0.0, 0.0]' '[0.0, 0.0, 0]'
rosservice call turtle2/teleport_absolute 4.5 6 0
rosservice call kill /turtle2
#4444444444
rosservice call spawn 6 8.5 0 /turtle2
rosservice call turtle2/teleport_absolute 6 7 0
rosservice call turtle2/teleport_absolute 7 7 0
rosservice call turtle2/teleport_absolute 7 8.5 0
rosservice call turtle2/teleport_absolute 7 6 0
rosservice call kill /turtle2
#000000000
rosservice call spawn 7.5 8.5 0 /turtle2
rosservice call turtle2/teleport_absolute 8.5 8.5 0
rosservice call turtle2/teleport_absolute 8.5 6 0
rosservice call turtle2/teleport_absolute 7.5 6 0
rosservice call turtle2/teleport_absolute 7.5 8.5 0
rosservice call kill /turtle2
#888888888888
rosservice call spawn 9 8 1.57 /turtle2
rostopic pub -1 /turtle2/cmd_vel geometry_msgs/Twist -- '[2, 0.0, 0.0]' '[0.0, 0.0, -3.14]'
rosservice call turtle2/teleport_absolute 9 6.5 4.7
rostopic pub -1 /turtle2/cmd_vel geometry_msgs/Twist -- '[2, 0.0, 0.0]' '[0.0, 0.0, 3.14]'
rosservice call turtle2/teleport_absolute 9 8 4.7
