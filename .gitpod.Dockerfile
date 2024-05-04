FROM kalilinux/kali-rolling

### Gitpod user ###
# '-l': see https://docs.docker.com/develop/develop-images/dockerfile_best-practices/#user
RUN useradd -l -u 33333 -G sudo -md /home/gitpod -s /bin/bash -p gitpod gitpod \
    # passwordless sudo for users in the 'sudo' group
    && sed -i.bkp -e 's/%sudo\s\+ALL=(ALL\(:ALL\)\?)\s\+ALL/%sudo ALL=NOPASSWD:ALL/g' /etc/sudoers

ENV HOME=/home/gitpod
WORKDIR $HOME
# custom Bash prompt
RUN { echo && echo "PS1='\[\e]0;\u \w\a\]\[\033[01;32m\]\u\[\033[00m\] \[\033[01;34m\]\w\[\033[00m\] \\\$ '" ; } >> .bashrc

### Gitpod user (2) ###
USER gitpod
# use sudo so that user does not get sudo usage info on (the first) login
RUN sudo echo "Running 'sudo' for Gitpod: success" && \
    # create .bashrc.d folder and source it in the bashrc
    mkdir /home/gitpod/.bashrc.d && \
    (echo; echo "for i in \$(ls \$HOME/.bashrc.d/*); do source \$i; done"; echo) >> /home/gitpod/.bashrc

### VNC ###
LABEL dazzle/layer=true
LABEL dazzle/test=tests/vnc.yaml
USER root

# Install VNC, X server, and Fluxbox window manager
RUN apt-get update && apt-get install -y \
    xvfb x11vnc fluxbox && \
    rm -rf /var/lib/apt/lists/*

ENV DISPLAY :99
ENV LANG=en_US.UTF-8

# Configure VNC
RUN mkdir ~/.vnc \
    && x11vnc -storepasswd 1234 ~/.vnc/passwd

# Add VNC startup script
COPY --chown=gitpod:gitpod startup.sh /startup.sh
RUN chmod +x /startup.sh

USER gitpod

# Switch back to root user for any additional setup
USER root

# Expose port 6080 for web VNC access
EXPOSE 6080
