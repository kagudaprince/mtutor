#!/bin/bash

CONFIGS_WORKSPACE="/home/prince/workspace/work/vdx_projects/support/local-config"
EUREKA_SERVER_WORKSPACE="/home/prince/workspace/work/vdx_projects/support/eureka-server"
CONFIG_SERVER_WORKSPACE="/home/prince/workspace/work/vdx_projects/support/config-server"
ZUUL_SERVER_WORKSPACE="/home/prince/workspace/work/vdx_projects/support/zuul-server"
OBSIDIAN_SCHEDULER_WORKSPACE="/home/prince/workspace/work/vdx_projects/support/obsidian-scheduler"
VDX_WORKSPACE="/home/prince/workspace/work/vdx-cloud"
PROJECT_PROFILE="local"
CONFIGS_BRANCH="vdx"

CURR_DIR="$(pwd)"

COMPOSE_BCK=$CURR_DIR/vdx-services-compose.yml.bck
if [ -f $COMPOSE_BCK ]; then
   echo "Template COMPOSE_BCK exists. using it"
   cp $COMPOSE_BCK $CURR_DIR/vdx-services-compose.yml
else
   echo "Template $COMPOSE_BCK doesn't exists. creating it"
   cp $CURR_DIR/vdx-services-compose.yml $COMPOSE_BCK
fi


echo "Starting vdx-services setup"
sed -i -E "s|EUREKA_SERVER_WORKSPACE|$EUREKA_SERVER_WORKSPACE|g" $CURR_DIR/vdx-services-compose.yml
sed -i -E "s|CONFIG_SERVER_WORKSPACE|$CONFIG_SERVER_WORKSPACE|g" $CURR_DIR/vdx-services-compose.yml
sed -i -E "s|ZUUL_SERVER_WORKSPACE|$ZUUL_SERVER_WORKSPACE|g" $CURR_DIR/vdx-services-compose.yml
sed -i -E "s|OBSIDIAN_SCHEDULER_WORKSPACE|$OBSIDIAN_SCHEDULER_WORKSPACE|g" $CURR_DIR/vdx-services-compose.yml
sed -i -E "s|VDX_WORKSPACE|$VDX_WORKSPACE|g" $CURR_DIR/vdx-services-compose.yml
sed -i -E "s|CONFIGS_WORKSPACE|$CONFIGS_WORKSPACE|g" $CURR_DIR/vdx-services-compose.yml
sed -i -E "s|VDX_WORKSPACE|$VDX_WORKSPACE|g" $CURR_DIR/vdx-services-compose.yml
sed -i -E "s|CONFIGS_WORKSPACE|$CONFIGS_WORKSPACE|g" $CURR_DIR/vdx-services-compose.yml
sed -i -E "s|PROJECT_PROFILE|$PROJECT_PROFILE|g" $CURR_DIR/vdx-services-compose.yml
sed -i -E "s|CONFIGS_BRANCH|$CONFIGS_BRANCH|g" $CURR_DIR/vdx-services-compose.yml

chmod +x $CURR_DIR/dockerfiles/setupfiles/java/entrypoint.sh
chmod +x $CURR_DIR/dockerfiles/setupfiles/java/startup.sh
echo "Done setting up vdx-services"