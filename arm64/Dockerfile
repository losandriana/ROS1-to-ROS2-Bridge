FROM arm64v8/ubuntu:20.04

#RUN sed -i 's|http://ports.ubuntu.com|https://ports.ubuntu.com|g' /etc/apt/sources.list

ENV DEBIAN_FRONTEND=noninteractive
ENV ROS_DISTRO_FOXY=foxy
ENV ROS_DISTRO_NOETIC=noetic

# Locale
RUN apt-get update && apt-get install -y \
    build-essential \
    make \
    cmake\
    curl \
    gnupg2 \
    lsb-release \
    && rm -rf /var/lib/apt/lists/*


# ROS repositories
RUN curl -sSL http://raw.githubusercontent.com/ros/rosdistro/master/ros.key \
    -o /usr/share/keyrings/ros-archive-keyring.gpg


RUN echo "deb [arch=arm64 signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] \
http://packages.ros.org/ros/ubuntu focal main" \
> /etc/apt/sources.list.d/ros1.list


RUN echo "deb [arch=arm64 signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] \
http://packages.ros.org/ros2/ubuntu focal main" \
> /etc/apt/sources.list.d/ros2.list


RUN apt-get update && \
    apt-get install -y \
    git \
    cmake \
    make \
    pkg-config \
    && rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -y \
    ros-noetic-ros-base

RUN apt-get update && apt-get install -y \
    ros-foxy-ros-base

RUN apt-get update && apt-get install -y \
    python3-colcon-common-extensions \
    python3-rosdep

# 5. Install CycloneDDS middleware
RUN apt-get update && apt-get install -y ros-foxy-rmw-cyclonedds-cpp && rm -rf /var/lib/apt/lists/*

# 6. Build the bridge from source exactly using your directory layout (with foxy branch fix)
WORKDIR /root
RUN mkdir -p ros1_bridge_ws/src

# We target the foxy branch directly so the C++ APIs match perfectly
RUN cd ros1_bridge_ws/src && git clone -b foxy https://github.com/ros2/ros1_bridge.git

# Environment must be sourced to compile the package correctly
#WORKDIR /root/ros1_bridge_ws
#RUN /bin/bash -c " \
    #source /opt/ros/noetic/setup.bash && \
    #source /opt/ros/foxy/setup.bash && \
    #export RMW_IMPLEMENTATION=rmw_cyclonedds_cpp && \
    #export ROS_DOMAIN_ID=42 && \
    #colcon build --packages-select ros1_bridge --cmake-force-configure"
