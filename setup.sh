#!/bin/bash

curr_dir="$(pwd)"
place_holder="CURR_DIR"
sed "s|$place_holder|$curr_dir|g" $curr_dir/docker-compose.yml
chmod +x $curr_dir/obsidian/entrypoint.sh
