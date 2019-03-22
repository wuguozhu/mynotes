#!/bin/bash

# kafka lag data format:GROUP,TOPIC,PARTITION,CURRENT-OFFSET,LOG-END-OFFSET,LAG,OWNER
# this is exec plugins example.
# kafka lag check 

kafka-run-class kafka.admin.ConsumerGroupCommand --describe --group comsumer25 --zookeeper hadoop2.hantele.com | sed -r 's/\s+/,/g' | awk -F ',' '{print "kafka-lag-check,group="$1",topic="$2",owner="$7" partition="$3",current-offset="$4 ",log-end-offset="$5",lag="$6 }' | tail -n +2
