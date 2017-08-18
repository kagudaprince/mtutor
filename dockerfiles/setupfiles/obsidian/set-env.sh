#!/bin/bash

sed -i -e "s|DB_USER|`echo $DB_USER`|g" /tmp/config/build.xml \
&& sed -i -e "s|DB_PASS|`echo $DB_PASS`|g" /tmp/config/build.xml \
&& sed -i -e "s|DB_URL|`echo $DB_URL`|g" /tmp/config/build.xml 
