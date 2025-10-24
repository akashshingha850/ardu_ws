# Quick Reference - ArduPilot Gazebo Simulation

## Start/Stop Commands

```bash
# Start simulation
./start_simulation.sh

# Stop simulation
# Press Ctrl+C in the terminal (cleanup is automatic)
```

## What Runs When You Start

When you run `./start_simulation.sh`, these processes start:
1. **Gazebo Server** - Physics simulation engine
2. **Gazebo Client** - GUI visualization
3. **ArduPilot SITL** - Software-In-The-Loop autopilot
4. **RViz2** - Robot visualization
5. **ROS2 Nodes** - Communication and control
6. **micro-ROS Agent** - DDS-XRCE bridge

## Common Issues & Solutions

### Issue: Gazebo won't start or shows black screen
```bash
# Stop everything with Ctrl+C, or manually:
pkill -9 -f "gz sim"

# Clean shared memory
rm -f /dev/shm/gz-*

# Restart
./start_simulation.sh
```

### Issue: "Model not found" error
```bash
# Check model path is set
echo $GZ_SIM_RESOURCE_PATH

# Should include: /home/ubuntu/ardu_ws/src/ardupilot_sitl_models/Gazebo/models
```

### Issue: Processes still running after stop
```bash
# Force kill everything
pkill -9 -f "gz sim"
pkill -9 -f "ardupilot"
pkill -9 -f "rviz2"
pkill -9 -f "ros2"

# Clean shared memory
rm -f /dev/shm/gz-*
rm -f /tmp/.gazebo*
```

### Issue: Port already in use
```bash
# Check what's using the port
netstat -tlnp | grep 5760

# Kill the process using that PID
kill -9 <PID>
```

### Issue: Simulation running slow
- Check if hardware acceleration is enabled
- Close unnecessary applications
- Reduce Gazebo rendering quality in GUI

## Process Monitoring

```bash
# See all simulation processes
ps aux | grep -E "gz sim|ardupilot|rviz2" | grep -v grep

# Watch CPU/memory usage
htop

# Monitor Gazebo specifically
watch -n 1 'ps aux | grep gz | grep -v grep'
```

## File Locations

```
~/ardu_ws/
├── start_simulation.sh              # Start script (with built-in cleanup)
├── STARTUP_README.md                # Full documentation
├── CUSTOM_MODEL_INFO.md             # Custom model info
└── src/
    └── ardupilot_gz/
        └── ardupilot_gz_gazebo/
            └── worlds/
                └── iris_runway.sdf  # World file (with roundabout)
```

## Keyboard Shortcuts (in Gazebo GUI)

- **Ctrl+R** - Reset simulation
- **Spacebar** - Pause/Resume
- **Ctrl+T** - Show/hide time panel
- **Mouse scroll** - Zoom
- **Middle mouse drag** - Pan
- **Right mouse drag** - Rotate view

## Logs

```bash
# ROS logs
cd ~/ardu_ws/log/latest_build

# ArduPilot logs
ls ~/ardu_ws/*.tlog

# Gazebo logs
ls ~/.gz/sim/
```

## Quick Rebuild

```bash
cd ~/ardu_ws
source /opt/ros/humble/setup.bash
colcon build --packages-select ardupilot_gz_gazebo
source install/setup.bash
```

---

**For detailed information, see `STARTUP_README.md`**
