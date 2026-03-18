# Dockerized ROS1-ROS2 Bridge

This guide walks you through running a Docker container that acts as a **ROS1-ROS2 bridge** using **ROS Noetic** (ROS1) and **ROS Foxy** (ROS2). It includes installation steps, environment setup, and launching the bridge for dynamic topic communication.

---

## 1. Run the Docker Container

Run the container in the host network to allow ROS nodes in different containers or on the host machine to communicate:

```bash
docker run -it --rm --network host your-docker-image:latest
```

## 2. Install ROS Dependencies

Once inside the container, update the package list and install the required ROS2 CycloneDDS packages:

```bash
apt update
apt install -y ros-foxy-rmw-cyclonedds-cpp ros-foxy-cyclonedds
```

## 3. Source ROS Environments

Source ROS1 and ROS2 environments to enable commands from both versions:

```bash
# Source ROS1 Noetic
source /opt/ros/noetic/setup.bash

# Source ROS2 Foxy
source /opt/ros/foxy/setup.bash
```


## 4. Build the ROS1-ROS2 Bridge

Navigate to your workspace and clone the bridge repository:

```bash
cd ~/ros1_bridge_ws
git clone https://github.com/ros2/ros1_bridge.git src/ros1_bridge
```
Build the bridge package:

```bash
colcon build --packages-select ros1_bridge --cmake-force-configure
source install/setup.bash
```


## 5. Set Environment Variables

Before running the bridge, configure the necessary environment variables:

```bash
# ROS1 Master URI
export ROS_MASTER_URI=http://<ROS1_MASTER_IP>:11311

# Bridge container IP
export ROS_IP=<BRIDGE_CONTAINER_IP>

# ROS2 DDS Implementation
export RMW_IMPLEMENTATION=rmw_cyclonedds_cpp

# ROS2 Domain ID
export ROS_DOMAIN_ID=42
```


## 6. Launch the ROS1-ROS2 Bridge

Run the dynamic bridge to forward all topics between ROS1 and ROS2:

```bash
ros2 run ros1_bridge dynamic_bridge --bridge-all-topics
```
