#!/bin/bash
CURR_DIR=`pwd`
JMXTRANS_OPTS="-Dport1=9393 -Durl1=localhost -DinfluxUrl=http://192.168.108.19:8096/ -DinfluxDb=kafka -DinfluxUser=telegraf -DinfluxPwd=telegraf"  SECONDS_BETWEEN_RUNS=15 JAR_FILE=jmxtrans-270-all.jar ${CURR_DIR}/jmxtrans.sh start ${CURR_DIR}/kafka.json &
