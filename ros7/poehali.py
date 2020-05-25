#!/usr/bin/env python

import rospy

from sensor_msgs.msg import LaserScan
from geometry_msgs.msg import Twist

side = {
	'right': 0,
	'front': 0,
	'left': 0,
	}

min_dist = 0.3
max_dist = 0.6

def callback(msg):
	global side
	side = {
	'right': min(msg.ranges[0:45]),
	'front': min(msg.ranges[46:134]),
	'left': min(msg.ranges[135:180]),
	}

def motion_forward():
	msg = Twist()
	msg.linear.x = 0.5
	msg.angular.z = 0
	return msg

def motion_right():
	msg = Twist()
	msg.linear.x = 0
	msg.angular.z = -0.5
	return msg

def motion_left():
	msg = Twist()
	msg.linear.x = 0
	msg.angular.z = 0.5
	return msg

def motion():
	global side
	if 	side['left'] > min_dist and side['left'] < max_dist and side['front'] > min_dist:
		return motion_forward()
	elif side['front'] < max_dist:
		return motion_right()
	elif 	side['left'] > max_dist :
		return motion_left()
	elif side['left'] < min_dist :
		return motion_right()

rospy.init_node('MOVEbyBogdick')

pub = rospy.Publisher('/cmd_vel', Twist, queue_size=10)
sub = rospy.Subscriber('/base_scan', LaserScan, callback)


while not rospy.is_shutdown():
	msg = motion()
	pub.publish(msg)