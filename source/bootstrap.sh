#!/bin/sh


# Script to set up a pair of CFEngine machines: hub and host

hub=hub.example.com
host2=host.example.com

echo bootstrapping $hub to itself
ssh $hub "sudo cf-agent -B $hub && sudo cf-agent"

echo bootstrapping $host2 to $hub
ssh $host2 sudo cf-agent -B $hub
