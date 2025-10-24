#!/bin/bash
# ArduPilot ROS2 Gazebo Build Script

cd ~/ardu_ws
source /opt/ros/humble/setup.bash

echo "Building ArduPilot ROS2 Gazebo workspace..."
colcon build

if [ $? -eq 0 ]; then
    echo ""
    echo "✓ Build successful!"
    echo ""
    echo "To use the workspace, run:"
    echo "  source install/setup.bash"
else
    echo ""
    echo "✗ Build failed!"
    exit 1
fi
