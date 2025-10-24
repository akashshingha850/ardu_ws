#!/bin/bash
# ArduPilot ROS2 Gazebo Startup Script
# Reference: https://ardupilot.org/dev/docs/ros2-gazebo.html
# Press Ctrl+C to stop the simulation

# Cleanup function
cleanup() {
    echo ""
    echo "Stopping simulation..."
    
    # Kill all simulation processes
    pkill -f "gz sim" 2>/dev/null
    pkill -f "ruby.*gz" 2>/dev/null
    pkill -f "ardupilot" 2>/dev/null
    pkill -f "rviz2" 2>/dev/null
    pkill -f "micro_ros_agent" 2>/dev/null
    
    # Clean shared memory
    rm -f /dev/shm/gz-* 2>/dev/null
    
    echo "✓ Simulation stopped"
    exit 0
}

# Trap Ctrl+C and call cleanup
trap cleanup SIGINT SIGTERM

cd ~/ardu_ws

# Set Gazebo model path to include custom models
export GZ_SIM_RESOURCE_PATH="$HOME/ardu_ws/src/ardupilot_sitl_models/Gazebo/models:${GZ_SIM_RESOURCE_PATH}"

source install/setup.bash
ros2 launch ardupilot_gz_bringup iris_runway.launch.py

# Call cleanup on normal exit
cleanup
