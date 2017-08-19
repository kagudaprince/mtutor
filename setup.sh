#!/bin/bash
echo "Starting vdx setup"

CURR_DIR="$(pwd)"

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

sed -i -E "s|$place_holder|$CURR_DIR|g" $CURR_DIR/all-platform-services-compose.yml
sed -i -E "s|$place_holder|$CURR_DIR|g" $CURR_DIR/db-compose.yml
sed -i -E "s|$place_holder|$CURR_DIR|g" $CURR_DIR/platform-services-compose.yml
sed -i -E "s|$place_holder|$CURR_DIR|g" $CURR_DIR/vdx-services-compose.yml

chmod +x $CURR_DIR/dockerfiles/setupfiles/obsidian/entrypoint.sh
chmod +x $CURR_DIR/dockerfiles/setupfiles/obsidian/startup.sh
chmod +x $CURR_DIR/dockerfiles/setupfiles/obsidian/set-env.sh
chmod +x $CURR_DIR/dockerfiles/setupfiles/wait-for-it.sh

mkdir $CURR_DIR/volumes
mkdir $CURR_DIR/volumes/sftp
mkdir $CURR_DIR/volumes/portainer
mkdir $CURR_DIR/volumes/oracle
mkdir $CURR_DIR/volumes/mysql
echo "Done with setup"
