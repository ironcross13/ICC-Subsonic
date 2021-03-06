#!/bin/sh

#create folders on config
mkdir -p /config/media/incoming
mkdir -p /config/media/podcast
mkdir -p /config/playlists
#mkdir -p /config/playlists/import
#mkdir -p /config/playlists/export
#mkdir -p /config/playlists/backup
mkdir -p /config/transcode

#copy transcode to config directory - transcode directory is subdir of path set from --home flag, do not alter
cp /var/subsonic/transcode/linux/* /config/transcode/

# enable/disable ssl based on env variable set from docker container run command
 if [[ $SSL == "yes" ]]; then
        echo "Enabling SSL for Subsonic"
        /var/subsonic/subsonic.sh --home=/config --host=0.0.0.0 --https-port=4050 --context-path=$CONTEXT_PATH --max-memory=$MAX_MEMORY --default-music-folder=/media --default-podcast-folder=/config/media/podcast --default-playlist-folder=/config/playlists 

 elif [[ $SSL == "no" ]]; then
        echo "Disabling SSL for Subdsonic"
        /var/subsonic/subsonic.sh --home=/config --host=0.0.0.0 --port=4040 --context-path=$CONTEXT_PATH --max-memory=$MAX_MEMORY --default-music-folder=/media --default-podcast-folder=/config/media/podcast --default-playlist-folder=/config/playlists 

 else
        echo "SSL not defined, defaulting to disabled"
        /var/subsonic/subsonic.sh --home=/config --host=0.0.0.0 --port=4040 --context-path=$CONTEXT_PATH --max-memory=$MAX_MEMORY --default-music-folder=/media --default-podcast-folder=/config/media/podcast --default-playlist-folder=/config/playlists 

 fi