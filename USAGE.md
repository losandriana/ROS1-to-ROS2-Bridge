      apt update

      apt install -y ros-foxy-rmw-cyclonedds-cpp ros-foxy-cyclonedds

      source /opt/ros/foxy/setup.bash
      echo $RMW_IMPLEMENTATION
      export RMW_IMPLEMENTATION=rmw_cyclonedds_cpp

      
