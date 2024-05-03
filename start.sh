#!/bin/bash

# Create a new VNC password file
mkdir -p /root/.vnc
echo "$VNC_PW" | vncpasswd -f > /root/.vnc/passwd
chmod 600 /root/.vnc/passwd

# Start the VNC server
vncserver -geometry 1920x1080 :1 -localhost no -alwaysshared -depth 24 &

# Start the Xfce desktop in virtual framebuffer mode
Xvfb :1 -ac -screen 0 1920x1080x24 & DISPLAY=:1 startxfce4 &

# Keep the container running
read -p "VNC server is running. Press any key to exit..." -n1 -s

# Stop the VNC server
vncserver -kill :1