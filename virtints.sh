#!/bin/bash

if [[ "$EUID" -ne 0 ]] ; then
	echo -n "This is meant to be run as root.\nExiting..."
	exit
fi

if [[ $1 == "-c" ]] ; then

	echo 'Creating tap0 interface...'
	ip tuntap add dev tap0 mode tap
	sleep 1
	echo 'Setting it up...'
	ip link set tap0 up promisc on
	sleep 1
	echo 'Starting the interface tap0...'
	virsh net-start default
	sleep 1
	echo 'Setting up virtual bridge interface virbr0...'
	brctl addif virbr0 tap0
	sleep 1
	echo 'Done.'

	else

		if [[ $1 == "-s" ]] ; then

			echo 'Starting virtual interface tap0...'
			ifconfig tap0 up
			sleep 1
			echo 'Starting virtual bridge interface virbr0 ...'
			ifconfig virbr0 up
			sleep 1
		fi

fi
