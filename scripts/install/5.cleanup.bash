#!/usr/bin/env bash

for task in autoremove autoclean clean
do
	apt-get -y -qq ${task} &> /dev/null
done