#!/bin/bash

# Start the X virtual framebuffer
Xvfb :99 &

# Start Fluxbox window manager
fluxbox &

# Start x11vnc server
x11vnc -forever -shared -rfbauth ~/.vnc/passwd -display :99 -rfbport 5900 &

# Keep the container running
tail -f /dev/null
