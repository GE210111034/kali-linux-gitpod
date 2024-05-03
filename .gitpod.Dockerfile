# creating .gitpod.Dockerfile to use kali linux image with vnc server

# use the official Kali Linux image
FROM kalilinux/kali-rolling

RUN apt-get update -y

# install the tools we need
RUN apt-get install -y xfce4
RUN apt-get install -y xfce4-terminal
RUN apt-get install -y xfce4-goodies
RUN apt-get install -y tightvncserver
RUN apt-get install -y git

# remove apt/lists/*
RUN rm -rf /var/lib/apt/lists/*

# set default shell
ENV SHELL=/bin/bash

# expose vnc port
EXPOSE 5901

# set vnc password
ENV VNC_PW="kjhbvyrx56879ubht$#@$%6789nBGYTREZ$5667U*&^%$#@"

# set up vnc server
COPY start.sh /start.sh
RUN chmod +x /start.sh

# Set the entrypoint
ENTRYPOINT ["/start.sh"]
