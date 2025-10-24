# Build Configuration for Gazebo Harmonic

## Issue
The workspace contains both old Ignition Gazebo packages (`ros_ign_*`) and newer Gazebo packages (`ros_gz_*`). Since you have Gazebo Harmonic installed, the old Ignition packages fail to build.

## Solution
Added `COLCON_IGNORE` files to skip incompatible packages.

## Ignored Packages

The following packages are ignored during build:

```
src/ros_gz/ros_ign_bridge/COLCON_IGNORE
src/ros_gz/ros_ign_gazebo/COLCON_IGNORE
src/ros_gz/ros_ign_interfaces/COLCON_IGNORE
src/ros_gz/ros_ign_image/COLCON_IGNORE
src/ros_gz/ros_ign_gazebo_demos/COLCON_IGNORE
src/ros_gz/ros_gz_image/COLCON_IGNORE
src/ros_gz/test_ros_gz_bridge/COLCON_IGNORE
```

## What Gets Built

✅ All ArduPilot packages
✅ Gazebo Harmonic packages (ros_gz_*)
✅ Custom models (ardupilot_sitl_models)
✅ Bringup and configuration packages

## Usage

### Build Everything
```bash
./build.sh
```
or
```bash
cd ~/ardu_ws
source /opt/ros/humble/setup.bash
colcon build
```

### Build Specific Package
```bash
cd ~/ardu_ws
source /opt/ros/humble/setup.bash
colcon build --packages-select PACKAGE_NAME
```

### Rebuild After Changes
```bash
cd ~/ardu_ws
source /opt/ros/humble/setup.bash
colcon build --packages-select ardupilot_gz_gazebo
```

## Why COLCON_IGNORE?

`COLCON_IGNORE` is a special file that tells colcon to completely skip a package during:
- Discovery
- Dependency resolution
- Building

This is the cleanest way to handle incompatible packages without deleting them from your workspace.

## Gazebo Harmonic vs Ignition Gazebo 6

| Old (Ignition) | New (Gazebo Harmonic) |
|----------------|----------------------|
| ros_ign_bridge | ros_gz_bridge |
| ros_ign_gazebo | ros_gz_sim |
| ros_ign_interfaces | ros_gz_interfaces |
| ros_ign_image | ros_gz_image |
| ignition-gazebo6 | gz-sim8 |

Your workspace uses the new Gazebo Harmonic packages, which is the correct choice for Ubuntu 22.04 with ROS 2 Humble.

## Troubleshooting

### If colcon build still fails

1. Clean the workspace:
   ```bash
   rm -rf ~/ardu_ws/build ~/ardu_ws/install ~/ardu_ws/log
   colcon build
   ```

2. Check for missing dependencies:
   ```bash
   cd ~/ardu_ws
   rosdep update
   rosdep install --from-paths src --ignore-src -y
   ```

### If you need to use Ignition packages

Remove the COLCON_IGNORE files:
```bash
find ~/ardu_ws/src -name "COLCON_IGNORE" -delete
```

Then install Ignition Gazebo 6:
```bash
sudo apt install ignition-gazebo6
```

## Summary

✅ No need to specify `--packages-skip` anymore
✅ Just run `colcon build` or `./build.sh`
✅ All necessary packages build successfully
✅ Simulation works with Gazebo Harmonic
