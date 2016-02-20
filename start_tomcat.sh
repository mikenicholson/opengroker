#!/bin/sh
service tomcat7 start

/opengrok/scripts/reindex.sh
