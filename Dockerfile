## Custom Dockerfile
FROM ct2034/vnc-ros-kinetic-full


ENV HOME /root

 

#----------------------------Install youbot simulation--------------------------

RUN  apt-get update \
  && apt-get install -y wget \
  && rm -rf /var/lib/apt/lists/*
RUN sudo  wget http://packages.osrfoundation.org/gazebo.key -O - | sudo apt-key add -

RUN sudo apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-key 421C365BD9FF1F717815A3895523BAEEB01FA116
RUN sudo apt-get update
RUN sudo apt-get install ros-kinetic-desktop-full

RUN sudo apt-get install -y	 ros-kinetic-ros-control ros-kinetic-ros-controllers ros-kinetic-gazebo-ros-control

RUN sudo mkdir catkin_ws && sudo mkdir catkin_ws/src
RUN git clone http://github.com/youbot/youbot_description.git -b kinetic-devel 
RUN git clone http://github.com/youbot/youbot_simulation.git
RUN sudo mv /root/youbot_description/   /root/catkin_ws/src  
RUn sudo mv /root/youbot_simulation/   /root/catkin_ws/src 

RUN echo "source /opt/ros/kinetic/setup.bash" >> ~/.bashrc  -c 'source ~/.bashrc'
RUN /bin/bash -c "source /opt/ros/kinetic/setup.bash" 
RUN /bin/bash -c "source /opt/ros/kinetic/setup.bash;cd /root/catkin_ws/;  catkin_make"
RUN echo "source catkin_ws/devel/setup.bash" >> ~/.bashrc  -c 'source ~/.bashrc'
RUN export PATH=$PATH:/usr/share/gazebo
RUN export LD_LIBRARY_PATH="/usr/lib/x86_64_linux_gun/:$LD_LIBRARY_PATH"

RUN sudo  apt install -y python-rosinstall python-rosinstall-generator python-wstool build-essential






