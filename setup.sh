#!/bin/bash

curr_dir="$(pwd)"
sed -i -E "s/CURR_DIR/$curr_dir/g" $curr_dir/docker-compose.yml
chmod +x $curr_dir/obsidian/entrypoint.sh
