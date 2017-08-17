#!/bin/bash

curr_dir="$(pwd)"
place_holder="CURR_DIR"
sed -i -E "s|$place_holder|$curr_dir|g" $curr_dir/docker-compose.yml
chmod +x $curr_dir/setupfiles/obsidian/entrypoint.sh
chmod +x $curr_dir/setupfiles/obsidian/startup.sh
chmod +x $curr_dir/setupfiles/obsidian/set-env.sh
mkdir $curr_dir/volumes
mkdir $curr_dir/volumes/sftp
mkdir $curr_dir/volumes/portainer
mkdir $curr_dir/volumes/oracle
