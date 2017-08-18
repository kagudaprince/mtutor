#!/bin/bash

exec 
   sed -i -e "s|DB_USER|`echo $DB_USER`|g" /opt/obsidian/4.3.0/obsidian.properties \
   && sed -i -e "s|DB_PASS|`echo $DB_PASS`|g" /opt/obsidian/4.3.0/obsidian.properties \
   && sed -i -e "s|DB_URL|`echo $DB_URL`|g" /opt/obsidian/4.3.0/obsidian.properties \
   && "/usr/bin/java" \
  -jar /opt/obsidian/4.3.0/jetty/start.jar \
  -Duser.timezone=$TIMEZONE \
  -DstartupRunnerClass=com.carfey.ops.run.NullRunner \
  -Dcarfey.properties.file="/opt/obsidian/4.3.0/obsidian.properties" \
  -Dlog4j.properties="/opt/obsidian/4.3.0/jetty/resources/log4j.properties" \
  -Dcatalina.base="/opt/obsidian/4.3.0/jetty" \
  -Djetty.logs="/opt/obsidian/4.3.0/jetty/logs" \
  -Djetty.home="/opt/obsidian/4.3.0/jetty" \
  -Djetty.base="/opt/obsidian/4.3.0/jetty" \
  -Djava.io.tmpdir="/tmp" \
   jetty.state="/opt/obsidian/4.3.0/jetty/jetty.state" jetty-started.xml
