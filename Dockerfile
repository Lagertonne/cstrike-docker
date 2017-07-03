FROM ubuntu
MAINTAINER lagertonne mail@lagertonne.de

RUN apt-get update -y && apt-get upgrade -y && \
    apt-get install -y wget lib32gcc1

RUN cd /root && \
    mkdir content Steam content/css && cd Steam && \
    wget http://media.steampowered.com/installer/steamcmd_linux.tar.gz && \
    tar -xvzf steamcmd_linux.tar.gz

RUN cd /root/Steam && ./steamcmd.sh +login anonymous +quit

RUN mkdir /root/cs16 && cd /root/Steam && \
    ./steamcmd.sh +login anonymous +force_install_dir "/root/cs16" +app_update 90 validate +quit && \
    ./steamcmd.sh +login anonymous +force_install_dir "/root/cs16" +app_update 90 validate +quit && \
    rm -r /root/cs16/steamapps/*

RUN cd /root/cs16/steamapps && wget https://raw.githubusercontent.com/dgibbs64/HLDS-appmanifest/master/appmanifest_70.acf && \
    ~/Steam/steamcmd.sh +login anonymous +force_install_dir "/root/cs16" +app_update 90 validate +quit; exit 0
    
RUN cd /root/cs16/steamapps && wget https://raw.githubusercontent.com/dgibbs64/HLDS-appmanifest/master/appmanifest_10.acf && \
    ~/Steam/steamcmd.sh +login anonymous +force_install_dir "/root/cs16" +app_update 90 validate +quit; exit 0

RUN cd /root/cs16/steamapps && \
    wget https://raw.githubusercontent.com/dgibbs64/HLDS-appmanifest/master/appmanifest_90.acf && \
    ~/Steam/steamcmd.sh +login anonymous +force_install_dir "/root/cs16" +app_update 90 validate +quit

EXPOSE 27016/udp

#RUN cd /root/cs16 && \
    #./hlds_run -game cstrike -port 27016 +maxplayers 20 +map de_dust2

WORKDIR /root/cs16

ENTRYPOINT ["./hlds_run", "-game cstrike", "-insecure", "-port 27016", "+maxplayers 32", "-console", "+map de_dust2", "+sv_lan 1"]

