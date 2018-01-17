# xfce-tigervnc

## The simples possible VNC container

In order to run container:

    docker run --name=xfce-tigervnc \
    -v vnc_home:/home \
    --shm-size 2G \
    -e VNC_USER=myusername -e USER_PW=987645321 \
    -e VNC_PW=123456789 \
    -p 5901:5901 -d \
    xfce-tigervnc