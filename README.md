# ROS1 to ROS2 Bridge Docker Image

[![Docker Pulls](https://img.shields.io/docker/pulls/losandriana/ros1-to-ros2-bridge)](https://hub.docker.com/r/losandriana/ros1-to-ros2-bridge)
[![Docker Image Size](https://img.shields.io/docker/image-size/losandriana/ros1-to-ros2-bridge/latest)](https://hub.docker.com/r/losandriana/ros1-to-ros2-bridge)

A Dockerized **ROS1-to-ROS2 bridge** that enables seamless communication between **ROS Noetic** (ROS1) and **ROS Foxy** (ROS2).  

These images are tested on **Raspberry Pi 5 Docker Engine** and **AMD64 Ubuntu systems**, and are designed for rapid deployment of ROS bridging functionality.

---

## Docker Hub Images

The Docker images are hosted on Docker Hub:

- **ARM64 (Raspberry Pi / ARM systems)**  
  `losandriana/ros1-to-ros2-bridge:latest`  
  https://hub.docker.com/r/losandriana/ros1-to-ros2-bridge  

- **AMD64 (Ubuntu / x86_64 systems)**  
  `losandriana/ros1_ros2_bridge_amd64:latest`  
  https://hub.docker.com/r/losandriana/ros1_ros2_bridge_amd64  

---

## Pull Images

You can pull the images depending on your architecture:

```bash
# ARM64 (Raspberry Pi / ARM systems)
docker pull losandriana/ros1-to-ros2-bridge:latest

# AMD64 (Ubuntu / x86_64 systems)
docker pull losandriana/ros1_ros2_bridge_amd64:latest
```
