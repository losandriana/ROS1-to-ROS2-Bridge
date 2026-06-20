# ==========================================
# Stage 1: Build ROS 1 & ROS 2 Binaries
# ==========================================
FROM ubuntu:focal AS builder

ENV DEBIAN_FRONTEND=noninteractive

# 1. Install standard bootstrap tools available in vanilla Ubuntu
RUN apt-get update && apt-get install -y \
    curl \
    gnupg2 \
    lsb-release \
    git \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# 2. Setup ROS 1 Noetic Repositories
RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu focal main" > /etc/apt/sources.list.d/ros1-latest.list' \
    && curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.key | apt-key add -

# 3. Setup ROS 2 Foxy Repositories
RUN curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg \
    && echo "deb [arch=amd64 signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu focal main" | tee /etc/apt/sources.list.d/ros2.list > /dev/null

# 4. Install ROS Base and the specific workspace build dependencies you requested
RUN apt-get update && apt-get install -y \
    ros-noetic-ros-base \
    ros-foxy-ros-base \
    cmake \
    make \
    pkg-config \
    python3-colcon-common-extensions \
    python3-rosdep \
    && rm -rf /var/lib/apt/lists/*

# 5. Install CycloneDDS middleware
RUN apt-get update && apt-get install -y ros-foxy-rmw-cyclonedds-cpp && rm -rf /var/lib/apt/lists/*

# 6. Build the bridge from source exactly using your directory layout (with foxy branch fix)
WORKDIR /root
RUN mkdir -p ros1_bridge_ws/src

# We target the foxy branch directly so the C++ APIs match perfectly
RUN cd ros1_bridge_ws/src && git clone -b foxy https://github.com/ros2/ros1_bridge.git

# Environment must be sourced to compile the package correctly
WORKDIR /root/ros1_bridge_ws
RUN /bin/bash -c " \
    source /opt/ros/noetic/setup.bash && \
    source /opt/ros/foxy/setup.bash && \
    export RMW_IMPLEMENTATION=rmw_cyclonedds_cpp && \
    export export ROS_DOMAIN_ID=42 && \
    colcon build --packages-select ros1_bridge --cmake-force-configure"
