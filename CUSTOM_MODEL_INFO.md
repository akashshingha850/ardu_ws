# Custom Model Added to Gazebo World

## War Memorial Roundabout Sheringham

### Model Location
```
/home/ubuntu/ardu_ws/src/ardupilot_sitl_models/Gazebo/models/the_war_memorial_roundabout_sheringham/gazebo
```
**Note**: The model files (model.config, model.sdf) are in the `gazebo` subdirectory.

### World File Modified
```
/home/ubuntu/ardu_ws/src/ardupilot_gz/ardupilot_gz_gazebo/worlds/iris_runway.sdf
```

### Changes Made

1. **Fixed model.sdf to use OBJ mesh** with relative path:
   ```xml
   <uri>source/model.obj</uri>
   ```
   Uses the OBJ format instead of DAE for better compatibility.

2. **Scaled model to 100x**:
   ```xml
   <scale>100 100 100</scale>
   ```
   Both visual and collision geometries are scaled uniformly by 100x to make the model visible.

3. **Added collision geometry** for proper physics interaction.

4. **Added model to iris_runway.sdf world** using absolute file path:
   ```xml
   <include>
     <uri>file:///home/ubuntu/ardu_ws/src/ardupilot_sitl_models/Gazebo/models/the_war_memorial_roundabout_sheringham/gazebo</uri>
     <name>war_memorial_roundabout</name>
     <pose degrees="true">50 50 0 0 0 90</pose>
   </include>
   ```
   - Position: X=50m, Y=50m, Z=0m
   - Rotation: 0° (you can adjust these values)
   - Uses `file://` URI since the model is in a non-standard location

3. **Model path**: The startup script sets `GZ_SIM_RESOURCE_PATH` for future model additions

### How to Adjust Position

To change the roundabout's position, edit the `<pose>` tag in the world file:
```xml
<pose degrees="true">X Y Z Roll Pitch Yaw</pose>
```

**Example positions**:
- Near runway: `<pose degrees="true">0 50 0 0 0 0</pose>`
- Further away: `<pose degrees="true">100 100 0 0 0 0</pose>`
- Different rotation: `<pose degrees="true">50 50 0 0 0 45</pose>` (45° yaw)

After changing the pose, rebuild:
```bash
cd ~/ardu_ws
source /opt/ros/humble/setup.bash
colcon build --packages-select ardupilot_gz_gazebo
```

### Adding More Models

To add other models from the same directory:

1. **List available models**:
   ```bash
   ls /home/ubuntu/ardu_ws/src/ardupilot_sitl_models/Gazebo/models/
   ```

2. **Check if model files are in a subdirectory**:
   ```bash
   ls /home/ubuntu/ardu_ws/src/ardupilot_sitl_models/Gazebo/models/MODEL_NAME/
   ```
   Look for `model.config` and `model.sdf` files. They might be in a subdirectory like `gazebo/`.

3. **Add to world file** (iris_runway.sdf):
   
   **If model files are directly in the model directory:**
   ```xml
   <include>
     <uri>file:///home/ubuntu/ardu_ws/src/ardupilot_sitl_models/Gazebo/models/MODEL_NAME</uri>
     <name>unique_model_name</name>
     <pose degrees="true">X Y Z Roll Pitch Yaw</pose>
   </include>
   ```
   
   **If model files are in a subdirectory (like `gazebo/`):**
   ```xml
   <include>
     <uri>file:///home/ubuntu/ardu_ws/src/ardupilot_sitl_models/Gazebo/models/MODEL_NAME/gazebo</uri>
     <name>unique_model_name</name>
     <pose degrees="true">X Y Z Roll Pitch Yaw</pose>
   </include>
   ```

4. **Rebuild**:
   ```bash
   cd ~/ardu_ws
   source /opt/ros/humble/setup.bash
   colcon build --packages-select ardupilot_gz_gazebo
   ```

### Run Simulation

Simply execute:
```bash
./start_simulation.sh
```

The roundabout will now appear in the Gazebo world along with the runway and iris drone!
