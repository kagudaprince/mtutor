#!/bin/bash

curr_dir="$(pwd)"
place_holder="CURR_DIR"
sed "s|$place_holder|$curr_dir|g" $curr_dir/docker-compose.yml
chmod +x $curr_dir/obsidian/entrypoint.sh
chmod +x $curr_dir/obsidian/startup.sh
chmod +x $curr_dir/obsidian/set-env.sh
