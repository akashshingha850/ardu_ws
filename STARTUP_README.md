# ArduPilot ROS2 Gazebo Simulation - Startup Guide

This directory contains scripts to easily build, launch, and manage ArduPilot simulations with ROS2 and Gazebo Harmonic.

## Quick Start

### Build Workspace

Simply run:
```bash
./build.sh
```

Or manually:
```bash
cd ~/ardu_ws
source /opt/ros/humble/setup.bash
colcon build
```

**Note**: Incompatible Ignition Gazebo packages are automatically ignored via `COLCON_IGNORE` files.

### Start Simulation

Simply run:
```bash
./start_simulation.sh
```

### Stop Simulation

Press `Ctrl+C` in the terminal. The script will automatically clean up all processes and shared memory.

## What Happens When You Stop

When you press `Ctrl+C`, the script automatically:
- ✅ Stops Gazebo server and client
- ✅ Stops ArduPilot SITL processes
- ✅ Stops RViz2
- ✅ Stops micro-ROS agent
- ✅ Cleans up shared memory

## Process Management

### Manual Cleanup (if needed)

If you need to manually clean up stuck processes:
```bash
# Kill all Gazebo processes
pkill -9 -f "gz sim"

# Kill ArduPilot
pkill -9 -f "ardupilot"

# Kill RViz
pkill -9 -f "rviz2"

# Clean shared memory
rm -f /dev/shm/gz-*
```

### Check Running Processes

To see what simulation processes are running:
```bash
ps aux | grep -E "gz sim|ardupilot|rviz2|ros2 launch"
```

This will display a menu where you can:
- Launch different simulation scenarios
- Build the workspace
- Run tests
- Specify a custom launch file

### Command-Line Mode

For automation or when you know exactly what you want to run:

```bash
# Build the workspace
./start_simulation.sh --build

# Run tests
./start_simulation.sh --test

# Launch Iris Runway (Copter) simulation
./start_simulation.sh --iris-runway

# Launch Iris Maze (Copter) simulation
./start_simulation.sh --iris-maze

# Launch WildThumper Playpen (Rover) simulation
./start_simulation.sh --wildthumper

# Show help
./start_simulation.sh --help
```

## Available Simulations

### 1. Iris Runway (Copter)
A copter simulation on a runway environment.
```bash
./start_simulation.sh --iris-runway
```

### 2. Iris Maze (Copter)
A copter simulation in a maze environment - great for testing navigation algorithms.
```bash
./start_simulation.sh --iris-maze
```

### 3. WildThumper Playpen (Rover)
A rover simulation in a playpen environment.
```bash
./start_simulation.sh --wildthumper
```

## Configuration

### Environment Variables

#### GZ_VERSION
Set the Gazebo version to use (`harmonic` or `garden`). Default is `harmonic`.

```bash
export GZ_VERSION=harmonic
./start_simulation.sh --iris-runway
```

It's recommended to add this to your `~/.bashrc`:
```bash
echo 'export GZ_VERSION=harmonic' >> ~/.bashrc
source ~/.bashrc
```

## Prerequisites

The script checks for:
1. ROS 2 Humble installation at `/opt/ros/humble`
2. Workspace directory at `~/ardu_ws`
3. Built workspace with `install/` directory

If the workspace is not built, the script will offer to build it automatically.

## What the Script Does

1. **Checks Prerequisites**: Verifies that ROS 2 and the workspace are set up correctly
2. **Sets Up Environment**: 
   - Sources ROS 2 Humble
   - Sets the Gazebo version
   - Sources the workspace
3. **Launches Simulation**: Starts ArduPilot SITL, Gazebo, and RViz in a single command

## Troubleshooting

### Workspace Not Built
If you see a warning about the workspace not being built:
```bash
./start_simulation.sh --build
```

### ROS 2 Not Found
Make sure ROS 2 Humble is installed:
```bash
ls /opt/ros/humble/setup.bash
```

### Gazebo Issues
Ensure OpenGL hardware acceleration is enabled. Software rendering will result in poor performance.

Check your Gazebo version:
```bash
gz sim --version
```

### Permission Denied
If you get a permission denied error:
```bash
chmod +x start_simulation.sh
```

## Manual Launch Commands

If you prefer to run commands manually:

```bash
# Navigate to workspace
cd ~/ardu_ws

# Source ROS 2
source /opt/ros/humble/setup.bash

# Set Gazebo version
export GZ_VERSION=harmonic

# Source workspace
source install/setup.bash

# Launch a simulation
ros2 launch ardupilot_gz_bringup iris_runway.launch.py
```

## Building the Workspace

To build or rebuild the workspace:

```bash
cd ~/ardu_ws
source /opt/ros/humble/setup.bash
colcon build --packages-up-to ardupilot_gz_bringup
```

## Running Tests

To verify your installation:

```bash
cd ~/ardu_ws
source install/setup.bash
colcon test --packages-select ardupilot_sitl ardupilot_dds_tests \
    ardupilot_gazebo ardupilot_gz_applications ardupilot_gz_description \
    ardupilot_gz_gazebo ardupilot_gz_bringup
colcon test-result --all --verbose
```

## Additional Resources

- **Official Documentation**: https://ardupilot.org/dev/docs/ros2-gazebo.html
- **ArduPilot GitHub**: https://github.com/ArduPilot/ardupilot
- **ArduPilot Gazebo Plugin**: https://github.com/ArduPilot/ardupilot_gz
- **ROS 2 Humble Docs**: https://docs.ros.org/en/humble/

## Directory Structure

```
~/ardu_ws/
├── start_simulation.sh       # This startup script
├── STARTUP_README.md         # This file
├── src/                      # Source packages
│   ├── ardupilot/
│   ├── ardupilot_gazebo/
│   ├── ardupilot_gz/
│   └── ...
├── build/                    # Build artifacts
├── install/                  # Installed packages
└── log/                      # Build and runtime logs
```

## Next Steps

After running a simulation successfully:

1. **Cartographer SLAM**: Learn about SLAM in the [Cartographer SLAM guide](https://ardupilot.org/dev/docs/ros2-cartographer-slam.html)
2. **ROS 2 Interfaces**: Explore available [ROS 2 interfaces](https://ardupilot.org/dev/docs/ros2-interfaces.html)
3. **Waypoint Navigation**: Check out the [waypoint goal interface](https://ardupilot.org/dev/docs/ros2-waypoint-goal-interface.html)

## Support

For questions, issues, and suggestions:
- **ArduPilot Forums**: https://discuss.ardupilot.org/
- **GitHub Issues**: https://github.com/ArduPilot/ardupilot_gz/issues

---

**Created**: October 14, 2025  
**Reference**: https://ardupilot.org/dev/docs/ros2-gazebo.html
