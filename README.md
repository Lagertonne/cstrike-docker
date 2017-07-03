# cstrike-docker
This is a Dockerfile, for a Counter Strike 1.6 Server. Be aware, this is only supposed for intranet use. I have no clue how it performs on "real" servers.

This branch adds the AMX Mod X

## Running
    docker build -t lagertonne/cs16 .
    docker run -d -p 27016:27016/udp lagertonne/cs16
    
