# Use the official Kali Linux image
FROM kalilinux/kali-rolling

RUN apt-get update -y

# Install necessary packages
RUN apt-get install -y xfce4
RUN apt-get install -y xfce4-terminal
RUN apt-get install -y xfce4-goodies
RUN apt-get install -y tightvncserver
RUN apt-get install -y git
RUN apt-get install -y xvfb  # Install xvfb package
RUN rm -rf /var/lib/apt/lists/*

# Set default shell
ENV SHELL=/bin/bash

# Expose VNC port
EXPOSE 5901

# Set VNC password
ENV VNC_PW="kjhbvyrx56879ubht$#@$%6789nBGYTREZ$5667U*&^%$#@"
ENV USER=gitpod
ENV DISPLAY=:1

# Copy start script and make it executable
COPY start.sh /start.sh
RUN chmod +x /start.sh

# Set the entrypoint
ENTRYPOINT ["/start.sh"]