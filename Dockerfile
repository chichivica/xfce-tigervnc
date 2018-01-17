FROM ubuntu

ENV VNC_PW=123456
ENV VNC_USER=user1
ENV USER_PW=123456
ENV HOME=/home/$VNC_USER
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update
RUN apt-get install xfce4 -y
RUN apt-get install xfce4-goodies -y
RUN apt-get purge -y pm-utils xscreensaver*
RUN apt-get install wget -y
RUN apt-get install sudo -y

EXPOSE 5901


#RUN useradd -p $USER_PW -G sudo -ms /bin/bash $VNC_USER
#RUN adduser --disabled-password --gecos '' $VNC_USER
RUN  useradd -ms /bin/bash --create-home $VNC_USER && echo "$VNC_USER:$USER_PW" | chpasswd && adduser $VNC_USER sudo


WORKDIR /home/$VNC_USER

RUN wget -qO- https://dl.bintray.com/tigervnc/stable/tigervnc-1.8.0.x86_64.tar.gz | tar xz --strip 1 -C /
RUN mkdir .vnc
RUN echo "$VNC_PW" | vncpasswd -f >> .vnc/passwd
RUN chmod 600 .vnc/passwd
RUN chown "$VNC_USER:$VNC_USER" -R "$HOME"


######################################install software#######################################################
RUN apt-get install mc vim htop net-tools -y
RUN apt-get install firefox -y

USER $VNC_USER

WORKDIR /home/$VNC_USER/

CMD ["/usr/bin/vncserver", "-fg"]