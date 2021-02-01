#!/bin/bash

# Check if print services daemon is running

ps -ef | grep cupsd | grep -v grep
