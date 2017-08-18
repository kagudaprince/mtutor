#!/bin/bash
echo "Starting vdx setup"

curr_dir="$(pwd)"

place_holder="CURR_DIR"


COMPOSE_BCK=$CURR_DIR/vdx-services-compose.yml.bck
if [ -f $COMPOSE_BCK ]; then
   echo "Template COMPOSE_BCK exists. using it"
   cp $COMPOSE_BCK $CURR_DIR/vdx-services-compose.yml
else
   echo "Template $COMPOSE_BCK doesn't exists. creating it"
   cp $CURR_DIR/vdx-services-compose.yml $COMPOSE_BCK
fi

COMPOSE_BCK=$CURR_DIR/all-platform-services-compose.yml.bck
if [ -f $COMPOSE_BCK ]; then
   echo "Template COMPOSE_BCK exists. using it"
   cp $COMPOSE_BCK $CURR_DIR/all-platform-services-compose.yml
else
   echo "Template $COMPOSE_BCK doesn't exists. creating it"
   cp $CURR_DIR/all-platform-services-compose.yml $COMPOSE_BCK
fi

COMPOSE_BCK=$CURR_DIR/platform-services-compose.yml.bck
if [ -f $COMPOSE_BCK ]; then
   echo "Template COMPOSE_BCK exists. using it"
   cp $COMPOSE_BCK $CURR_DIR/platform-services-compose.yml
else
   echo "Template $COMPOSE_BCK doesn't exists. creating it"
   cp $CURR_DIR/platform-services-compose.yml $COMPOSE_BCK
fi

COMPOSE_BCK=$CURR_DIR/db-compose.yml.bck
if [ -f $COMPOSE_BCK ]; then
   echo "Template COMPOSE_BCK exists. using it"
   cp $COMPOSE_BCK $CURR_DIR/db-compose.yml
else
   echo "Template $COMPOSE_BCK doesn't exists. creating it"
   cp $CURR_DIR/db-compose.yml $COMPOSE_BCK
fi

sed -i -E "s|$place_holder|$curr_dir|g" $curr_dir/all-platform-services-compose.yml
sed -i -E "s|$place_holder|$curr_dir|g" $curr_dir/db-compose.yml
sed -i -E "s|$place_holder|$curr_dir|g" $curr_dir/platform-services-compose.yml
sed -i -E "s|$place_holder|$curr_dir|g" $curr_dir/vdx-services-compose.yml

chmod +x $curr_dir/dockerfiles/setupfiles/obsidian/entrypoint.sh
chmod +x $curr_dir/dockerfiles/setupfiles/obsidian/startup.sh
chmod +x $curr_dir/dockerfiles/setupfiles/obsidian/set-env.sh

mkdir $curr_dir/volumes
mkdir $curr_dir/volumes/sftp
mkdir $curr_dir/volumes/portainer
mkdir $curr_dir/volumes/oracle
mkdir $curr_dir/volumes/mysql
echo "Done with setup"
